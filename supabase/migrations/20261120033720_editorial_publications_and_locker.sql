begin;

alter table public.pdf_notebooks add column source_kind text not null default 'pdf'
  check (source_kind in ('pdf', 'image'));
update public.pdf_notebooks set source_kind = 'image'
  where title ~ '^이미지 손풀이 [0-9]+장\.pdf$';
grant insert(source_kind) on public.pdf_notebooks to authenticated;

create function private.editorial_admin() returns boolean
language sql stable security definer set search_path = '' as $$
  select exists (select 1 from private.admin_accounts where user_id = (select auth.uid()));
$$;
revoke all on function private.editorial_admin() from public;
grant execute on function private.editorial_admin() to authenticated;

create table public.editorial_publications (
  solution_id uuid primary key references public.solutions(id) on delete cascade,
  source text not null check (source in ('kice', 'education', 'book', 'school')),
  title text not null check (char_length(title) between 1 and 160),
  metadata text not null check (char_length(metadata) between 1 and 240),
  topic text not null check (char_length(topic) between 1 and 100),
  difficulty text check (difficulty in ('semi', 'advanced', 'killer')),
  approach text not null check (char_length(approach) between 1 and 450),
  published_at timestamptz not null default now()
);
alter table public.editorial_publications enable row level security;
create policy editorial_public_read on public.editorial_publications for select to anon, authenticated
  using (exists (
    select 1 from public.solutions s join public.problems p on p.id = s.problem_id
    where s.id = solution_id and s.public and p.public and not p.withdrawn
  ));
create policy editorial_admin_write on public.editorial_publications for all to authenticated
  using ((select private.editorial_admin())) with check ((select private.editorial_admin()) and
    exists (select 1 from public.solutions s join public.problems p on p.id = s.problem_id
      where s.id = solution_id and s.owner_id = (select auth.uid()) and s.public and p.public and not p.withdrawn));
revoke all on public.editorial_publications from public, anon, authenticated;
grant select on public.editorial_publications to anon, authenticated;
grant insert, update, delete on public.editorial_publications to authenticated;
grant all on public.editorial_publications to service_role;

create table public.archive_recipient_shares (
  export_id uuid not null,
  owner_id uuid not null,
  recipient_id uuid not null references public.profiles(id) on delete cascade,
  primary key (export_id, recipient_id),
  foreign key (export_id, owner_id) references public.archive_exports(id, owner_id) on delete cascade,
  check (owner_id <> recipient_id)
);
create index archive_recipient_lookup on public.archive_recipient_shares(recipient_id, export_id);
alter table public.archive_recipient_shares enable row level security;
create policy archive_recipient_read on public.archive_recipient_shares for select to authenticated
  using ((select auth.uid()) in (owner_id, recipient_id));
create policy archive_recipient_add on public.archive_recipient_shares for insert to authenticated
  with check (owner_id = (select auth.uid()));
create policy archive_recipient_remove on public.archive_recipient_shares for delete to authenticated
  using (owner_id = (select auth.uid()));
revoke all on public.archive_recipient_shares from public, anon, authenticated;
grant select, insert, delete on public.archive_recipient_shares to authenticated;
grant all on public.archive_recipient_shares to service_role;

create policy archive_exports_recipient_read on public.archive_exports for select to authenticated
  using (exists (select 1 from public.archive_recipient_shares s where s.export_id = archive_exports.id and s.recipient_id = (select auth.uid())));
-- The owner insert policy already checks storage.objects. Keep the reverse lookup outside its RLS path.
create function private.can_read_shared_export(object_name text) returns boolean
language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.archive_exports e join public.archive_recipient_shares s on s.export_id = e.id
    where e.path = object_name and s.recipient_id = (select auth.uid())
      and (e.source_clip_id is null or exists (
        select 1 from public.pdf_clips c where c.id = e.source_clip_id and c.deleted_at is null
      ))
  );
$$;
revoke all on function private.can_read_shared_export(text) from public;
grant execute on function private.can_read_shared_export(text) to authenticated;
create policy solution_exports_recipient_read on storage.objects for select to authenticated
  using (bucket_id = 'solution-exports' and private.can_read_shared_export(name));

create function private.remove_trashed_clip_recipient_shares() returns trigger
language plpgsql security invoker set search_path = '' as $$
begin
  delete from public.archive_recipient_shares s using public.archive_exports e
    where e.id = s.export_id and e.source_clip_id = new.id and e.owner_id = (select auth.uid());
  return new;
end;
$$;
create trigger remove_trashed_clip_recipient_shares
  after update of deleted_at on public.pdf_clips
  for each row when (old.deleted_at is null and new.deleted_at is not null)
  execute function private.remove_trashed_clip_recipient_shares();

create table public.editorial_pack_entitlements (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  title text not null check (char_length(title) between 1 and 160),
  file_path text not null check (file_path ~ '^[a-z0-9][a-z0-9/_-]*\.pdf$'),
  purchased_at timestamptz not null default now(),
  unique (user_id, file_path)
);
alter table public.editorial_pack_entitlements enable row level security;
create policy editorial_packs_own on public.editorial_pack_entitlements for select to authenticated
  using (user_id = (select auth.uid()));
revoke all on public.editorial_pack_entitlements from public, anon, authenticated;
grant select on public.editorial_pack_entitlements to authenticated;
grant all on public.editorial_pack_entitlements to service_role;
insert into storage.buckets (id, name, public, allowed_mime_types)
  values ('editorial-packs', 'editorial-packs', false, array['application/pdf']);
create policy editorial_pack_file_read on storage.objects for select to authenticated
  using (bucket_id = 'editorial-packs' and exists (
    select 1 from public.editorial_pack_entitlements p where p.file_path = name and p.user_id = (select auth.uid())
  ));

commit;

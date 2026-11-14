begin;
create table public.english_translations (
 owner_id uuid not null references public.profiles(id) on delete cascade,
 question smallint not null check (question between 18 and 43 and question <> 42),
 sentence smallint not null check (sentence >= 0 and sentence < case question
  when 18 then 9
  when 19 then 13
  when 20 then 7
  when 21 then 10
  when 22 then 5
  when 23 then 6
  when 24 then 9
  when 25 then 5
  when 26 then 8
  when 27 then 5
  when 28 then 10
  when 29 then 8
  when 30 then 7
  when 31 then 9
  when 32 then 9
  when 33 then 7
  when 34 then 8
  when 35 then 7
  when 36 then 7
  when 37 then 7
  when 38 then 9
  when 39 then 9
  when 40 then 5
  when 41 then 11
  when 43 then 28
  else 0 end),
 translation text not null check (char_length(btrim(translation)) between 1 and 3000),
 created_at timestamptz not null default now(),
 primary key (owner_id, question, sentence)
);
create index english_translations_feed on public.english_translations (created_at desc, owner_id, question, sentence);
alter table public.english_translations enable row level security;
revoke all on public.english_translations from public, anon, authenticated;
grant select on public.english_translations to anon, authenticated;
grant insert (owner_id, question, sentence, translation), update (owner_id, question, sentence, translation) on public.english_translations to authenticated;
create policy english_translations_read on public.english_translations for select to anon, authenticated using (true);
create policy english_translations_insert on public.english_translations for insert to authenticated with check (owner_id = (select auth.uid()));
create policy english_translations_update on public.english_translations for update to authenticated using (owner_id = (select auth.uid())) with check (owner_id = (select auth.uid()));
notify pgrst, 'reload schema';
commit;

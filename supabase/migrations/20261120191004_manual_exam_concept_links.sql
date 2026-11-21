begin;

-- Automatic suggestions follow the question's current unit. An editor can
-- explicitly connect a concept from another unit or an unclassified question.
alter policy exam_concept_links_read on public.exam_concept_links using (
  review_state <> 'rejected'
  and exists (
    select 1 from public.concepts c
    where c.id = concept_id and c.unit_id = exam_concept_links.unit_id
  )
  and exists (
    select 1 from public.exam_questions q
    where q.id = question_id and (
      q.unit_id = exam_concept_links.unit_id
      or (exam_concept_links.method = 'manual' and exam_concept_links.review_state = 'confirmed')
    )
  )
);

create or replace function private.review_exam_concept(p_question_id uuid, p_concept_id uuid, p_state text)
returns void language plpgsql security definer set search_path = '' as $$
declare
  uid uuid := auth.uid();
begin
  if uid is null or not exists (select 1 from private.admin_accounts where user_id = uid) then
    raise exception 'ADMIN_REQUIRED';
  end if;

  if p_state = 'link' then
    insert into public.exam_concept_links
      (question_id, concept_id, unit_id, match_kind, evidence, method, review_state, reviewed_by, reviewed_at)
    select q.id, c.id, c.unit_id, 'content', '[]'::jsonb, 'manual', 'confirmed', uid, now()
    from public.exam_questions q cross join public.concepts c
    where q.id = p_question_id and c.id = p_concept_id and c.published
    on conflict (question_id, concept_id) do update
      set unit_id = excluded.unit_id, method = 'manual', review_state = 'confirmed',
          reviewed_by = uid, reviewed_at = now();
  elsif p_state in ('confirmed', 'candidate', 'rejected') then
    update public.exam_concept_links l
    set review_state = p_state, reviewed_by = uid, reviewed_at = now()
    from public.exam_questions q, public.concepts c
    where l.question_id = p_question_id and l.concept_id = p_concept_id
      and q.id = l.question_id and c.id = l.concept_id and c.unit_id = l.unit_id
      and ((l.method = 'manual' and p_state <> 'candidate')
        or (l.method <> 'manual' and q.unit_id = l.unit_id));
  else
    raise exception 'INVALID_REVIEW_STATE';
  end if;

  if not found then raise exception 'CONCEPT_LINK_NOT_FOUND'; end if;
end $$;

commit;

create or replace function public.page_official_exam_catalog(p_filters jsonb, p_offset integer default 0)
returns jsonb
language sql
stable
security invoker
set search_path = ''
as $$
  with filtered as materialized (
    select p.id, p.title, p.grade, p.subject, p.unit, p.source, p.exam_question_id,
      p.source_details->'classification' as classification,
      coalesce(nullif(d.level, 'basic'), 'unclassified') as difficulty,
      s.id as session_id, s.calendar_year, s.month, s.provider, q.section, q.question_no, q.variant
    from public.exam_sessions s
    join public.exam_questions q on q.session_id = s.id
    join public.problems p on p.exam_question_id = q.id
    left join public.problem_difficulties d on d.problem_id = p.id
    where p.public and not p.withdrawn and q.variant <> 'even'
      and (p_filters->>'examSource' is null or s.provider = p_filters->>'examSource')
      and (p_filters->>'grade' is null or p.grade = p_filters->>'grade')
      and (p_filters->>'year' is null or s.calendar_year::text = p_filters->>'year')
      and (p_filters->>'month' is null or s.month::text = p_filters->>'month')
      and (p_filters->>'variant' is null or q.variant = p_filters->>'variant')
      and (p_filters->>'difficulty' is null or coalesce(nullif(d.level,'basic'),'unclassified') = p_filters->>'difficulty')
      and p_filters->>'paper' is null
      and (p_filters->>'review' is null
        or (p_filters->>'review' = 'review' and p.source_details->'classification'->>'needs_review' = 'true')
        or (p_filters->>'review' = 'manual' and p.source_details->'classification'->>'method' = 'manual'))
      and (p_filters->>'subject' is null or p.subject = p_filters->>'subject'
        or (p_filters->>'related' = 'true' and (p.source_details->'classification'->'related_unit_keys')
          ?| array(select jsonb_array_elements_text(coalesce(p_filters->'relatedSubjectKeys','[]'::jsonb)))))
      and (p_filters->>'unit' is null or p.source_details->'classification'->>'unit_key' = p_filters->>'unit'
        or (p_filters->>'related' = 'true' and (p.source_details->'classification'->'related_unit_keys') ? (p_filters->>'unit')))
      and (p_filters->>'q' is null or pg_catalog.strpos(lower(concat_ws(' ', p.title, p.subject, p.unit,
        p.source_details->>'label', p.source_details->'classification'->'evidence')), lower(left(p_filters->>'q', 80))) > 0)
  ), page as (
    select *,
      row_number() over (order by calendar_year desc, month desc, grade collate "C",
        case provider when 'kice' then 0 else 1 end,
        array_position(array['common','math','probability','calculus','geometry']::text[], section),
        question_no, id) as position
    from filtered
    order by position
    limit 24 offset greatest(coalesce(p_offset,0),0)
  )
  select jsonb_build_object(
    'total', case when coalesce(p_offset,0) <= 0 then (select count(*) from filtered) end,
    'sessions', case when coalesce(p_offset,0) <= 0 then (
      select coalesce(jsonb_agg(jsonb_build_object('calendar_year',calendar_year,'month',month,'grade',grade,'provider',provider)), '[]'::jsonb)
      from public.exam_sessions) end,
    'rows', (
      select coalesce(jsonb_agg(jsonb_build_object(
        'id', a.id, 'title', a.title, 'grade', a.grade, 'subject', a.subject, 'unit', a.unit, 'source', a.source,
        'exam_question_id', a.exam_question_id, 'classification', a.classification, 'difficulty', a.difficulty,
        'solution_problem_id', coalesce(
          (select a.id where exists(select 1 from public.solutions sol where sol.problem_id=a.id and sol.public)),
          (select p.id from public.exam_questions q join public.problems p on p.exam_question_id=q.id
            where a.variant='odd' and q.session_id=a.session_id and q.variant='even' and q.section=a.section
              and q.question_no=a.question_no and p.public and not p.withdrawn
              and exists(select 1 from public.solutions sol where sol.problem_id=p.id and sol.public))
        )
      ) order by a.position), '[]'::jsonb)
      from page a)
  );
$$;

revoke execute on function public.page_official_exam_catalog(jsonb, integer) from public;
grant execute on function public.page_official_exam_catalog(jsonb, integer) to anon, authenticated;
notify pgrst, 'reload schema';

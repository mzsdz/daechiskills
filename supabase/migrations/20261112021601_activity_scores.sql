begin;

drop trigger if exists profiles_signup_points on public.profiles;

create schema if not exists activity_score_private;
revoke all on schema activity_score_private from public;
grant usage on schema activity_score_private to anon, authenticated;

create or replace function activity_score_private.ranking()
returns jsonb language sql stable security definer set search_path = '' as $$
  with published as materialized (
    select s.id, s.owner_id, s.problem_id, s.created_at
    from public.solutions s join public.problems p on p.id = s.problem_id
    where s.public and p.public and not p.withdrawn
  ), first_by_author as (
    select distinct on (problem_id, owner_id) problem_id, owner_id, created_at, id
    from published order by problem_id, owner_id, created_at, id
  ), medals as (
    select owner_id, row_number() over (partition by problem_id order by created_at, id) as position
    from first_by_author
  ), contributions as (
    select owner_id as member_id, count(*) * 20 as points from published group by owner_id
    union all
    select owner_id, sum(case position when 1 then 100 when 2 then 80 when 3 then 60 end)::bigint
    from medals where position <= 3 group by owner_id
    union all
    select following_id, count(*) * 1000 from public.follows where status = 'accepted' group by following_id
    union all
    select follower_id, count(*) * 500 from public.follows where status = 'accepted' group by follower_id
    union all
    select b.user_id, count(*) * 10
    from public.solution_saves b join published s on s.id = b.solution_id
    where b.user_id <> s.owner_id group by b.user_id
  ), totals as (
    select member_id, sum(points)::bigint as score from contributions group by member_id
  ), leaders as (
    select p.id, p.name, t.score
    from totals t join public.profiles p on p.id = t.member_id
    order by t.score desc, p.id limit 50
  )
  select jsonb_build_object(
    'leaders', coalesce((select jsonb_agg(to_jsonb(l) order by l.score desc, l.id) from leaders l), '[]'::jsonb),
    'myScore', case when auth.uid() is not null
      then coalesce((select score from totals where member_id = auth.uid()), 0) end
  );
$$;

revoke all on function activity_score_private.ranking() from public;
grant execute on function activity_score_private.ranking() to anon, authenticated;

create or replace function public.activity_score_ranking()
returns jsonb language sql stable security invoker set search_path = '' as $$
  select activity_score_private.ranking();
$$;

revoke all on function public.activity_score_ranking() from public;
grant execute on function public.activity_score_ranking() to anon, authenticated;
notify pgrst, 'reload schema';
commit;

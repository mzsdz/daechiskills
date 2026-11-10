begin;

-- Expose only totals and the caller's own flag. Bookmark identities stay private.
create schema if not exists problem_metrics_private;
revoke all on schema problem_metrics_private from public, anon, authenticated;
grant usage on schema problem_metrics_private to anon, authenticated;

create or replace function problem_metrics_private.problem_save_counts(p_problem_ids uuid[])
returns table(problem_id uuid, save_count bigint, saved_by_me boolean)
language plpgsql stable security definer set search_path = '' as $$
declare caller uuid := (select auth.uid());
begin
  if coalesce(cardinality(p_problem_ids), 0) > 100 then
    raise exception 'TOO_MANY_PROBLEMS' using errcode = '22023';
  end if;
  return query
    select p.id, count(s.user_id), coalesce(bool_or(s.user_id = caller), false)
    from public.problems p
    left join public.problem_saves s on s.problem_id = p.id
      and (p.public is true or s.user_id = caller)
    where p.id = any(coalesce(p_problem_ids, '{}'::uuid[]))
      and p.withdrawn is false
      and (p.public is true or (caller is not null and p.owner_id = caller))
    group by p.id;
end;
$$;
revoke all on function problem_metrics_private.problem_save_counts(uuid[]) from public, anon, authenticated;
grant execute on function problem_metrics_private.problem_save_counts(uuid[]) to anon, authenticated;

create or replace function public.problem_save_counts(p_problem_ids uuid[])
returns table(problem_id uuid, save_count bigint, saved_by_me boolean)
language sql stable security invoker set search_path = '' as $$
  select * from problem_metrics_private.problem_save_counts(p_problem_ids);
$$;
revoke all on function public.problem_save_counts(uuid[]) from public, anon, authenticated;
grant execute on function public.problem_save_counts(uuid[]) to anon, authenticated;

comment on function public.problem_save_counts(uuid[]) is
  'At most 100 IDs: public non-withdrawn problem save totals plus caller flag. For a private problem, only its owner may see their own save count. No other saver identities are returned.';

notify pgrst, 'reload schema';
commit;

-- Editorial review on 2026-11-27 (Asia/Seoul), restricted to the pending historical catalog.
-- Source crosswalk: the 2021 수학Ⅰ solutions identify the original stems, tracks and numbers
-- on PDF pages 63 (square pyramid), 61 (trapezoid), and 60 (theater seats), respectively.
-- https://www.ebsi.co.kr/ebs/pot/potg/retrieveCourseDetailNw.ebs?bookId=LB00000004093
begin;

create temp table ebs_archive_review on commit drop as
with sources as (
  select
    'https://lwdw.ebsi.co.kr/UpDown/ebsi_lms/bookans/EBS_%EC%88%98%EB%8A%A5%20%EA%B8%B0%EC%B6%9C%EC%9D%98%20%EB%AF%B8%EB%9E%98_%EC%88%98%ED%95%99%E2%85%A0_%EC%A0%95%EB%8B%B5%EA%B3%BC%ED%95%B4%EC%84%A4%5B20210108093256979%5D.pdf' as math_i,
    'https://lwdw.ebsi.co.kr/UpDown/LZ/bookimages/preview/EBS%202022%ED%95%99%EB%85%84%EB%8F%84%20%EC%88%98%EB%8A%A5%20%EA%B8%B0%EC%B6%9C%EC%9D%98%20%EB%AF%B8%EB%9E%98%20%EC%88%98%ED%95%99%EC%98%81%EC%97%AD%20%EA%B8%B0%ED%95%98%5B20201222163942533%5D.pdf' as geometry
)
select p.id as problem_id, s.calendar_year, q.variant, items.level, items.source_url
from sources
cross join lateral (values
  -- 2022 수학Ⅰ, 삼각함수 1등급 고난도 08. EBS prints 10.7%. CP varies along EC;
  -- the cosine law gives the extrema of cos(angle BPD).
  ('f8bff98b3003cf695006960eaabdf110'::uuid, 1993, 8, 'math', 15, 'killer', math_i || '#page=45'),
  -- Same unit, item 01 (27.6%). The preview also prints the original track and number.
  -- Constant triangle area yields xy sin(angle BPC)=2 in the right trapezoid.
  ('6dcfa75502900be4aac65f15746554a8'::uuid, 1994, 11, 'natural', 21, 'advanced', math_i || '#page=40'),
  -- Same 1995 CSAT, humanities/arts 21. Compared both KICE papers: stem, diagram,
  -- three assertions and all five choices are identical to EBS 21105-0067.
  -- Editorial 준킬러 based on the same 1등급 고난도 exercise and solution.
  -- Humanities/arts original: https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001097&m=0403&s=suneung
  ('6dcfa75502900be4aac65f15746554a8'::uuid, 1994, 11, 'humanities-arts', 21, 'advanced',
   'https://lwdw.ebsi.co.kr/UpDown/LZ/bookimages/preview/EBS%202022%ED%95%99%EB%85%84%EB%8F%84%20%EC%88%98%EB%8A%A5%20%EA%B8%B0%EC%B6%9C%EC%9D%98%20%EB%AF%B8%EB%9E%98%20%EC%88%98%ED%95%99%EC%98%81%EC%97%AD%20%EC%88%98%ED%95%99%E2%85%A0%5B20201222163524455%5D.pdf#page=2'),
  -- Same unit, item 07 (13.5%). The 15 and 30 degree arcs determine the theater seat area.
  ('48658246361c8a2930d58e1691a9a030'::uuid, 1996, 11, 'humanities-arts', 24, 'killer', math_i || '#page=44'),
  -- 2022 기하 p.12, 21109-0013. Printed difficulty 상. Editorial 준킬러:
  -- combining the two focus/directrix conditions produces a quadratic for the triangle height.
  -- Same original problem for both booklets. Solution PDF LB00000004480, pp.5–6.
  ('1327cf0eedf0a2c172abb5c3b77db210'::uuid, 2010, 11, 'math-a', 14, 'advanced', geometry || '#page=12')
) as items(session_id, year, month, section, number, level, source_url)
join public.exam_sessions s on (s.id,s.calendar_year,s.month)=(items.session_id,items.year,items.month)
  and s.grade='고3' and s.provider='kice'
join public.exam_questions q on (q.session_id,q.section,q.question_no)=(s.id,items.section,items.number)
join public.problems p on p.exam_question_id=q.id and p.public and not p.withdrawn;

alter table ebs_archive_review add primary key (problem_id);
do $$
begin
  if (select count(*) from ebs_archive_review) <> 6
    or (select count(*) from ebs_archive_review where variant <> 'even') <> 5 then
    raise exception 'EBS archive review does not match the expected exam catalog';
  end if;
end $$;

insert into public.problem_difficulties (problem_id, level, classification_method, source_url, rule_version)
select problem_id, level, 'manual', source_url, 'archive-ebs-future-review-v1'
from ebs_archive_review
on conflict (problem_id) do nothing;

commit;

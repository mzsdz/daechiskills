-- Reviewed historical difficulties. Source review date 2026-11-26 (Asia/Seoul).
-- All evidence is item-specific. Percentages are intentionally absent from stored difficulties.
-- Section math-a-integral denotes 미분과 적분 only. Same-number CSAT booklet variants share difficulty.
begin;
create temp table review_input on commit drop as
select session_id, year, month, grade, section, level, source_url, unnest(numbers) as n
from (values
-- 수능 20년사 177쪽 예시 3. 두 성장률을 구분해 0.037(1+r)^5=0.05(1.07)^5를 세우고 로그표로 역산한다. 편집 검토. https://orbi.kr/download/united/68984295/2
('f8bff98b3003cf695006960eaabdf110'::uuid, 1993, 8, '고3', 'math', 'semi', 'https://orbi.kr/download/united/68984295/2', ARRAY[20]),
-- 원문 풀이에 따른 편집 검토. 세 번째 합성에서 단조 구간이 여덟 개가 되는 것을 추론하고 각 구간에서 대각선과의 교점을 세어야 한다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001079&m=0403&s=suneung
('615092ba5cf93c58a92a4d6d464d2b99'::uuid, 1993, 11, '고3', 'math', 'advanced', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001079&m=0403&s=suneung', ARRAY[17]),
-- 원문 풀이에 따른 편집 검토. 두 식에서 1/r을 소거해 조화평균을 얻고 역방향에서도 r이 존재하는 조건을 확인한다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001082&m=0403&s=suneung
('6dcfa75502900be4aac65f15746554a8'::uuid, 1994, 11, '고3', 'natural', 'semi', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001082&m=0403&s=suneung', ARRAY[24]),
-- 원문 풀이에 따른 편집 검토. 정육면체 면대각선을 변으로 갖는 정사면체가 두 개임을 찾아 그 면을 중복 없이 센다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001104&m=0403&s=suneung
('58440c7c469290b0eaa535c215af80cb'::uuid, 1995, 11, '고3', 'natural', 'semi', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001104&m=0403&s=suneung', ARRAY[17]),
-- 원문 풀이에 따른 편집 검토. 반직선 위 점들의 편각 범위를 구하고 이를 5제곱근의 편각과 더해 실수가 되는 경우를 거른다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001104&m=0403&s=suneung
('58440c7c469290b0eaa535c215af80cb'::uuid, 1995, 11, '고3', 'natural', 'advanced', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001104&m=0403&s=suneung', ARRAY[24]),
-- 원문 풀이에 따른 편집 검토. 원뿔의 한 바퀴를 전개해 두 끝점을 잇고, 꼭짓점에서 이 직선으로 내린 수선의 발을 오르막과 내리막의 경계로 찾는다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001087&m=0403&s=suneung
('48658246361c8a2930d58e1691a9a030'::uuid, 1996, 11, '고3', 'natural', 'advanced', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001087&m=0403&s=suneung', ARRAY[24]),
-- 원문 풀이에 따른 편집 검토. 공통근이 없으면 두 조건의 교집합 A가 유한하다. 최댓값은 공통근 하나만 둘 때 합집합의 크기 7+9−1이다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001087&m=0403&s=suneung
('48658246361c8a2930d58e1691a9a030'::uuid, 1996, 11, '고3', 'natural', 'advanced', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001087&m=0403&s=suneung', ARRAY[29]),
-- 원문 풀이에 따른 편집 검토. 사인법칙을 적용해 sin(APO)=sin(PAO)/2로 바꾸고 직각이 되는 위치에서 상한에 도달함을 확인한다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001063&m=0403&s=suneung
('049e4387eb81c55ec432577112a925f4'::uuid, 1997, 11, '고3', 'natural', 'advanced', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001063&m=0403&s=suneung', ARRAY[24]),
-- 원문 풀이에 따른 편집 검토. 두 접합점에서 연속성과 양쪽 수평 접선의 기울기를 조건으로 바꾸어 삼차식 계수를 정한다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001063&m=0403&s=suneung
('049e4387eb81c55ec432577112a925f4'::uuid, 1997, 11, '고3', 'natural', 'semi', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001063&m=0403&s=suneung', ARRAY[29]),
-- 원문 풀이에 따른 편집 검토. 60초 통과량을 60v/f(v)로 모델링하고 v/20+5/v의 최솟값으로 바꾼다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001034&m=0403&s=suneung
('3372274ef39545d3b98d32cccbf725d3'::uuid, 1998, 11, '고3', 'natural', 'semi', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001034&m=0403&s=suneung', ARRAY[24]),
-- 원문 풀이에 따른 편집 검토. 두 변환이 만드는 회전과 대칭을 조합하여 좌표의 자리 교환과 부호 조합을 중복 없이 센다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001034&m=0403&s=suneung
('3372274ef39545d3b98d32cccbf725d3'::uuid, 1998, 11, '고3', 'natural', 'semi', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001034&m=0403&s=suneung', ARRAY[29]),
-- 원문 풀이에 따른 편집 검토. 3년을 한 주기로 지수식을 세우고 로그로 구한 주기 수를 연도로 환산한다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001044&m=0403&s=suneung
('49e05e021290ea3812d3417a07ec85d9'::uuid, 1999, 11, '고3', 'natural', 'semi', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001044&m=0403&s=suneung', ARRAY[24]),
-- 원문 풀이에 따른 편집 검토. 최근 소비량과 이전 누적량이 같다는 조건을 누적량의 10년 배증으로 바꾸고, 매장량 소진 때 누적량 a+b에 도달하는 시점을 구한다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001013&m=0403&s=suneung
('b19400a0f914efdee468a1d524aa23db'::uuid, 2000, 11, '고3', 'natural', 'semi', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001013&m=0403&s=suneung', ARRAY[24]),
-- 원문 풀이에 따른 편집 검토. 같은 원의 원주각과 보조 정삼각형으로 평행을 확인한 뒤 주어진 두 삼각형의 닮음 대응변을 고른다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001028&m=0403&s=suneung
('031188dbf64c56cc50eece0494d0e5b5'::uuid, 2001, 11, '고3', 'natural', 'semi', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001028&m=0403&s=suneung', ARRAY[17]),
-- 원문 풀이에 따른 편집 검토. 평균비용 g=f/x를 미분해 f′−g=xg′를 유도하고 극솟점 좌우에서 두 그래프의 상하 관계가 바뀌는 방향을 판정한다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001122&m=0403&s=suneung
('0d7dfee742293a807e18582bfa7c8452'::uuid, 2002, 11, '고3', 'natural', 'advanced', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001122&m=0403&s=suneung', ARRAY[24]),
-- 원문 풀이에 따른 편집 검토. 정의역 양 끝에서의 극한과 x=1에서의 극댓값을 함께 확인해 수평선이 두 번 만나는 자연수 범위를 센다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001122&m=0403&s=suneung
('0d7dfee742293a807e18582bfa7c8452'::uuid, 2002, 11, '고3', 'natural', 'semi', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001122&m=0403&s=suneung', ARRAY[29]),
-- 원문 풀이에 따른 편집 검토. 속도가 바뀌는 20분과 방향이 바뀌는 30분을 구분하고 뒤쪽 음의 변위를 포함해 높이를 계산한다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001140&m=0403&s=suneung
('051b8a72ea91bb97089e60bf75fa6a8d'::uuid, 2003, 11, '고3', 'natural', 'semi', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001140&m=0403&s=suneung', ARRAY[24]),
-- 원문 풀이에 따른 편집 검토. 두 중심은 공통현의 수직이등분선에 있고 외부 닮음의 중심은 두 공통외접선 위에 있다. 이를 결합해 x축과 수직이등분선의 교점으로 바꾼다. https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001140&m=0403&s=suneung
('051b8a72ea91bb97089e60bf75fa6a8d'::uuid, 2003, 11, '고3', 'natural', 'advanced', 'https://www.suneung.re.kr/boardCnts/view.do?boardID=1500235&boardSeq=3001140&m=0403&s=suneung', ARRAY[29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5141117 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 31쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('8e37ac53168fa8241f1369f74a8bd393'::uuid, 2004, 11, '고3', 'math-a', 'semi', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[4,6,7,11,13,16,17,20,21]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5141117 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 31쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('8e37ac53168fa8241f1369f74a8bd393'::uuid, 2004, 11, '고3', 'math-a', 'semi', 'https://parkhyosam.tistory.com/5141117', ARRAY[8,14,15,19,23,24]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5141117 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 31쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('8e37ac53168fa8241f1369f74a8bd393'::uuid, 2004, 11, '고3', 'math-a', 'advanced', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[10,22]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5141117 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 31쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('8e37ac53168fa8241f1369f74a8bd393'::uuid, 2004, 11, '고3', 'math-a', 'advanced', 'https://parkhyosam.tistory.com/5141117', ARRAY[25]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5141117 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 31쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('8e37ac53168fa8241f1369f74a8bd393'::uuid, 2004, 11, '고3', 'math-a-integral', 'advanced', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[28,29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5141117 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 31쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('8e37ac53168fa8241f1369f74a8bd393'::uuid, 2004, 11, '고3', 'math-a-integral', 'semi', 'https://parkhyosam.tistory.com/5141117', ARRAY[30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5141117 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 31쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('8e37ac53168fa8241f1369f74a8bd393'::uuid, 2004, 11, '고3', 'math-b', 'semi', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[4,5,7,8,9,11,12,13,15,18,22,28]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5141117 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 31쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('8e37ac53168fa8241f1369f74a8bd393'::uuid, 2004, 11, '고3', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/5141117', ARRAY[6,14,20,24,26,27]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5141117
('8e37ac53168fa8241f1369f74a8bd393'::uuid, 2004, 11, '고3', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/5141117', ARRAY[10]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5141117 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 31쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('8e37ac53168fa8241f1369f74a8bd393'::uuid, 2004, 11, '고3', 'math-b', 'semi', 'https://parkhyosam.tistory.com/5141117', ARRAY[16,17,21,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5141117 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 31쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('8e37ac53168fa8241f1369f74a8bd393'::uuid, 2004, 11, '고3', 'math-b', 'advanced', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[19,23,25,29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/5141515 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=29&sub_cod=2101&years=2006 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 46쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('51bc013a97cf29a35ffa875ca0f04662'::uuid, 2005, 11, '고3', 'math-a', 'semi', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[4,7,12,15,16,19,20,22,23,25]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/5141515 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=29&sub_cod=2101&years=2006 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 46쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('51bc013a97cf29a35ffa875ca0f04662'::uuid, 2005, 11, '고3', 'math-a', 'advanced', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[8,21,24]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/5141515 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=29&sub_cod=2101&years=2006 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 46쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('51bc013a97cf29a35ffa875ca0f04662'::uuid, 2005, 11, '고3', 'math-a', 'semi', 'https://parkhyosam.tistory.com/5141515', ARRAY[9,11,13,14,17]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/5141515 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=29&sub_cod=2101&years=2006 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 46쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('51bc013a97cf29a35ffa875ca0f04662'::uuid, 2005, 11, '고3', 'math-a', 'advanced', 'https://parkhyosam.tistory.com/5141515', ARRAY[10]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/5141515 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=29&sub_cod=2101&years=2006 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 46쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('51bc013a97cf29a35ffa875ca0f04662'::uuid, 2005, 11, '고3', 'math-a-integral', 'semi', 'https://parkhyosam.tistory.com/5141515', ARRAY[26,29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/5141515 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=29&sub_cod=2101&years=2006 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 46쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('51bc013a97cf29a35ffa875ca0f04662'::uuid, 2005, 11, '고3', 'math-a-integral', 'advanced', 'https://parkhyosam.tistory.com/5141515', ARRAY[27,28]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/5141515 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=29&sub_cod=2101&years=2006 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 46쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('51bc013a97cf29a35ffa875ca0f04662'::uuid, 2005, 11, '고3', 'math-a-integral', 'advanced', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/5141515 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=29&sub_cod=2200&years=2006 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 45쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('51bc013a97cf29a35ffa875ca0f04662'::uuid, 2005, 11, '고3', 'math-b', 'semi', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[4,5,7,9,10,18,19,20,21,22,26]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/5141515 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=29&sub_cod=2200&years=2006 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 45쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('51bc013a97cf29a35ffa875ca0f04662'::uuid, 2005, 11, '고3', 'math-b', 'semi', 'https://parkhyosam.tistory.com/5141515', ARRAY[6,8,24,25,27]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/5141515 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=29&sub_cod=2200&years=2006 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 45쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('51bc013a97cf29a35ffa875ca0f04662'::uuid, 2005, 11, '고3', 'math-b', 'advanced', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[11,13,14,15,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/5141515 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=29&sub_cod=2200&years=2006 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 45쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('51bc013a97cf29a35ffa875ca0f04662'::uuid, 2005, 11, '고3', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/5141515', ARRAY[12,16,17,23,28,29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20060601/math_hsj_1.pdf https://parkhyosam.tistory.com/5195058
('5fc2092e5403a541d81f5f097ca02540'::uuid, 2006, 6, '고1', 'math', 'semi', 'https://parkhyosam.tistory.com/5195058', ARRAY[3,10,11,12,13,15,16,17,18,19,20,21,24,25,27]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20060601/math_hsj_1.pdf https://parkhyosam.tistory.com/5195058
('5fc2092e5403a541d81f5f097ca02540'::uuid, 2006, 6, '고1', 'math', 'advanced', 'https://parkhyosam.tistory.com/5195058', ARRAY[8,9,14,29,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20060602/mathga_hsj_1.pdf https://parkhyosam.tistory.com/5194921
('8cf9fe380828912398a048d0aac3efaf'::uuid, 2006, 6, '고2', 'math-a', 'semi', 'https://parkhyosam.tistory.com/5194921', ARRAY[2,5,6,7,8,9,10,11,13,14,15,16,17,18,19,20,21,23,25,26,27,29,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/5141580 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=36&sub_cod=2101&years=2006
('ae681cfe82a697d7f3b0be8babb0086e'::uuid, 2006, 6, '고3', 'math-a', 'semi', 'https://parkhyosam.tistory.com/5141580', ARRAY[5,7,9,13,14,15,16,17,20,21,22,25]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/5141580 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=36&sub_cod=2101&years=2006
('ae681cfe82a697d7f3b0be8babb0086e'::uuid, 2006, 6, '고3', 'math-a', 'advanced', 'https://parkhyosam.tistory.com/5141580', ARRAY[8,10,11,23,24]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20060602/mathga_hsj_1.pdf https://parkhyosam.tistory.com/5194921
('8cf9fe380828912398a048d0aac3efaf'::uuid, 2006, 6, '고2', 'math-a', 'advanced', 'https://parkhyosam.tistory.com/5194921', ARRAY[12,24,28]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/5141580 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=36&sub_cod=2101&years=2006
('ae681cfe82a697d7f3b0be8babb0086e'::uuid, 2006, 6, '고3', 'math-a-integral', 'semi', 'https://parkhyosam.tistory.com/5141580', ARRAY[27,28,29,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20060602/mathna_hsj_1.pdf https://parkhyosam.tistory.com/5194921
('8cf9fe380828912398a048d0aac3efaf'::uuid, 2006, 6, '고2', 'math-b', 'semi', 'https://parkhyosam.tistory.com/5194921', ARRAY[2,3,4,5,6,7,10,11,12,13,17,18,19,20,22,23,25,28,29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/5141580 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=36&sub_cod=2200&years=2006
('ae681cfe82a697d7f3b0be8babb0086e'::uuid, 2006, 6, '고3', 'math-b', 'semi', 'https://parkhyosam.tistory.com/5141580', ARRAY[5,7,8,9,10,11,12,14,15,16,17,19,20,21,22,25,26]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20060602/mathna_hsj_1.pdf https://parkhyosam.tistory.com/5194921
('8cf9fe380828912398a048d0aac3efaf'::uuid, 2006, 6, '고2', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/5194921', ARRAY[8,9,14,15,16,21,24,26,27,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/5141580 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=36&sub_cod=2200&years=2006
('ae681cfe82a697d7f3b0be8babb0086e'::uuid, 2006, 6, '고3', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/5141580', ARRAY[13,23,24,27,28,29,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20060906/mathga_hsj.pdf https://parkhyosam.tistory.com/5141747
('cb49846e7753fccbcb0a03f28e35e61d'::uuid, 2006, 9, '고3', 'math-a', 'semi', 'https://parkhyosam.tistory.com/5141747', ARRAY[4,6,8,12,13,14,15,16,17,21,22,23,24]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20060906/mathga_hsj.pdf https://parkhyosam.tistory.com/5141747
('cb49846e7753fccbcb0a03f28e35e61d'::uuid, 2006, 9, '고3', 'math-a', 'advanced', 'https://parkhyosam.tistory.com/5141747', ARRAY[9,25]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20060906/mathga_hsj.pdf https://parkhyosam.tistory.com/5141747
('cb49846e7753fccbcb0a03f28e35e61d'::uuid, 2006, 9, '고3', 'math-a-integral', 'semi', 'https://parkhyosam.tistory.com/5141747', ARRAY[28,29,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20060906/mathna_hsj.pdf https://parkhyosam.tistory.com/5141755 | 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20060906/mathna_hsj.pdf https://parkhyosam.tistory.com/5141747
('cb49846e7753fccbcb0a03f28e35e61d'::uuid, 2006, 9, '고3', 'math-b', 'semi', 'https://parkhyosam.tistory.com/5141755', ARRAY[5,7,8,10,11,12,13,15,16,17,19,20,21,22,23,25,29,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20060906/mathna_hsj.pdf https://parkhyosam.tistory.com/5141755 | 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20060906/mathna_hsj.pdf https://parkhyosam.tistory.com/5141747
('cb49846e7753fccbcb0a03f28e35e61d'::uuid, 2006, 9, '고3', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/5141755', ARRAY[14,24]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20061116/mathga1_hsj.pdf https://parkhyosam.tistory.com/5141835 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=41&sub_cod=2101&years=2007 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 60쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('57e5c52b3e1663b72a3465e875a197ce'::uuid, 2006, 11, '고3', 'math-a', 'semi', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[4,5,6,10,13,18,19]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20061116/mathga1_hsj.pdf https://parkhyosam.tistory.com/5141835 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=41&sub_cod=2101&years=2007 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 60쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('57e5c52b3e1663b72a3465e875a197ce'::uuid, 2006, 11, '고3', 'math-a', 'semi', 'https://parkhyosam.tistory.com/5141835', ARRAY[7,8,12,14,15,17,22]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20061116/mathga1_hsj.pdf https://parkhyosam.tistory.com/5141835 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=41&sub_cod=2101&years=2007 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 60쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('57e5c52b3e1663b72a3465e875a197ce'::uuid, 2006, 11, '고3', 'math-a', 'advanced', 'https://parkhyosam.tistory.com/5141835', ARRAY[9,16,25]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20061116/mathga1_hsj.pdf https://parkhyosam.tistory.com/5141835 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=41&sub_cod=2101&years=2007 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 60쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('57e5c52b3e1663b72a3465e875a197ce'::uuid, 2006, 11, '고3', 'math-a', 'advanced', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[20,21,23,24]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20061116/mathga1_hsj.pdf https://parkhyosam.tistory.com/5141835 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=41&sub_cod=2101&years=2007 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 60쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('57e5c52b3e1663b72a3465e875a197ce'::uuid, 2006, 11, '고3', 'math-a-integral', 'semi', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[26]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20061116/mathga1_hsj.pdf https://parkhyosam.tistory.com/5141835 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=41&sub_cod=2101&years=2007 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 60쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('57e5c52b3e1663b72a3465e875a197ce'::uuid, 2006, 11, '고3', 'math-a-integral', 'semi', 'https://parkhyosam.tistory.com/5141835', ARRAY[27,28]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20061116/mathga1_hsj.pdf https://parkhyosam.tistory.com/5141835 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=41&sub_cod=2101&years=2007 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 60쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('57e5c52b3e1663b72a3465e875a197ce'::uuid, 2006, 11, '고3', 'math-a-integral', 'advanced', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20061116/mathga1_hsj.pdf https://parkhyosam.tistory.com/5141835 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=41&sub_cod=2101&years=2007 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 60쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('57e5c52b3e1663b72a3465e875a197ce'::uuid, 2006, 11, '고3', 'math-a-integral', 'killer', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20061116/mathna2_hsj.pdf https://parkhyosam.tistory.com/5141835 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=41&sub_cod=2200&years=2007 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 59쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('57e5c52b3e1663b72a3465e875a197ce'::uuid, 2006, 11, '고3', 'math-b', 'semi', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[5,7,8,9,11,13,18,19,21,26,29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20061116/mathna2_hsj.pdf https://parkhyosam.tistory.com/5141835 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=41&sub_cod=2200&years=2007 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 59쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('57e5c52b3e1663b72a3465e875a197ce'::uuid, 2006, 11, '고3', 'math-b', 'semi', 'https://parkhyosam.tistory.com/5141835', ARRAY[10,20,27,28]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20061116/mathna2_hsj.pdf https://parkhyosam.tistory.com/5141835 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=41&sub_cod=2200&years=2007 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 59쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('57e5c52b3e1663b72a3465e875a197ce'::uuid, 2006, 11, '고3', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/5141835', ARRAY[12,14,15,16,17,22,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20061116/mathna2_hsj.pdf https://parkhyosam.tistory.com/5141835 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=41&sub_cod=2200&years=2007 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 59쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('57e5c52b3e1663b72a3465e875a197ce'::uuid, 2006, 11, '고3', 'math-b', 'advanced', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[23,24,25]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20070315/math_hsj.pdf https://parkhyosam.tistory.com/5194983
('205e7eb2a9822080c8a21f713d06fefc'::uuid, 2007, 3, '고2', 'math', 'semi', 'https://parkhyosam.tistory.com/5194983', ARRAY[2,4,5,7,9,10,12,15,16,18,21]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20070315/math_hsj.pdf https://parkhyosam.tistory.com/5194983
('205e7eb2a9822080c8a21f713d06fefc'::uuid, 2007, 3, '고2', 'math', 'advanced', 'https://parkhyosam.tistory.com/5194983', ARRAY[8,11,13,14,17,19,20,23,24,25,27,28,29,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20070315/math_hsj.pdf https://parkhyosam.tistory.com/5194983
('205e7eb2a9822080c8a21f713d06fefc'::uuid, 2007, 3, '고2', 'math', 'killer', 'https://parkhyosam.tistory.com/5194983', ARRAY[26]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20070316/mathna_hsj.pdf https://parkhyosam.tistory.com/5141908 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=42&sub_cod=2101&years=2007
('e1e160d2f3fb03123440d5d668002b67'::uuid, 2007, 3, '고3', 'math-a', 'advanced', 'https://parkhyosam.tistory.com/5141908', ARRAY[5,10,11,15,23,24,25,27,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20070316/mathna_hsj.pdf https://parkhyosam.tistory.com/5141908 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=42&sub_cod=2101&years=2007
('e1e160d2f3fb03123440d5d668002b67'::uuid, 2007, 3, '고3', 'math-a', 'semi', 'https://parkhyosam.tistory.com/5141908', ARRAY[7,9,12,13,14,17,18,19,20,21,22,26,28,29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20070316/mathna_hsj.pdf https://parkhyosam.tistory.com/5141908 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=42&sub_cod=2200&years=2007
('e1e160d2f3fb03123440d5d668002b67'::uuid, 2007, 3, '고3', 'math-b', 'semi', 'https://parkhyosam.tistory.com/5141908', ARRAY[4,5,6,7,8,10,12,13,14,16,18,19,20,21,26]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20070316/mathna_hsj.pdf https://parkhyosam.tistory.com/5141908 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=42&sub_cod=2200&years=2007
('e1e160d2f3fb03123440d5d668002b67'::uuid, 2007, 3, '고3', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/5141908', ARRAY[11,15,17,22,23,24,25,27,28,29,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20070418/mathga_hsj.pdf https://parkhyosam.tistory.com/5141939
('87fa9e1f34f70d1d041358d90178e008'::uuid, 2007, 4, '고3', 'math-a', 'semi', 'https://parkhyosam.tistory.com/5141939', ARRAY[2,3,5,8,9,10,11,12,14,17,20,23,24,25]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20070418/mathga_hsj.pdf https://parkhyosam.tistory.com/5141939
('87fa9e1f34f70d1d041358d90178e008'::uuid, 2007, 4, '고3', 'math-a', 'advanced', 'https://parkhyosam.tistory.com/5141939', ARRAY[15,16,19,21,22]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20070418/mathga_hsj.pdf https://parkhyosam.tistory.com/5141939
('87fa9e1f34f70d1d041358d90178e008'::uuid, 2007, 4, '고3', 'math-b', 'semi', 'https://parkhyosam.tistory.com/5141939', ARRAY[2,3,4,5,6,10,13,18,19,20,22,26,28,29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20070418/mathga_hsj.pdf https://parkhyosam.tistory.com/5141939
('87fa9e1f34f70d1d041358d90178e008'::uuid, 2007, 4, '고3', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/5141939', ARRAY[8,9,11,12,14,15,16,17,21,23,24,25,27,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5309053 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 74쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('bd35c69ad2afb891418fe4c54a493329'::uuid, 2007, 11, '고3', 'math-a', 'semi', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[4,6,8,9,16,20,21,25]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5309053 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 74쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('bd35c69ad2afb891418fe4c54a493329'::uuid, 2007, 11, '고3', 'math-a', 'semi', 'https://parkhyosam.tistory.com/5309053', ARRAY[23,24]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5309053 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 74쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('bd35c69ad2afb891418fe4c54a493329'::uuid, 2007, 11, '고3', 'math-a-integral', 'semi', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[27]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5309053 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 74쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('bd35c69ad2afb891418fe4c54a493329'::uuid, 2007, 11, '고3', 'math-a-integral', 'semi', 'https://parkhyosam.tistory.com/5309053', ARRAY[28,29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5309053 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 74쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('bd35c69ad2afb891418fe4c54a493329'::uuid, 2007, 11, '고3', 'math-a-integral', 'advanced', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5309053 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 73쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('bd35c69ad2afb891418fe4c54a493329'::uuid, 2007, 11, '고3', 'math-b', 'semi', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[3,5,7,8,12,13,14,15,19,22,27]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5309053 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 73쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('bd35c69ad2afb891418fe4c54a493329'::uuid, 2007, 11, '고3', 'math-b', 'semi', 'https://parkhyosam.tistory.com/5309053', ARRAY[10,17,23,25,26]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5309053 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 73쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('bd35c69ad2afb891418fe4c54a493329'::uuid, 2007, 11, '고3', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/5309053', ARRAY[16,21,29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5309053 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 73쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('bd35c69ad2afb891418fe4c54a493329'::uuid, 2007, 11, '고3', 'math-b', 'killer', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[24]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 같은 학년도와 유형을 분석한 이동섭의 아주대 연구와 대조. https://parkhyosam.tistory.com/5309053 | 이동섭, 아주대 교육대학원 석사학위논문, PDF 73쪽. 구간이 두 단계를 걸치면 단독 판정 제외. https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255
('bd35c69ad2afb891418fe4c54a493329'::uuid, 2007, 11, '고3', 'math-b', 'advanced', 'https://dcoll.ajou.ac.kr/dcollection/common/orgView/000000009255', ARRAY[30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20080415/mathga_hsj.pdf https://parkhyosam.tistory.com/6266432
('942300b9935abb7fce5dc1c7a9560364'::uuid, 2008, 4, '고3', 'math-a', 'semi', 'https://parkhyosam.tistory.com/6266432', ARRAY[4,5,6,9,11,12,13,15,17,19]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20080415/mathga_hsj.pdf https://parkhyosam.tistory.com/6266432
('942300b9935abb7fce5dc1c7a9560364'::uuid, 2008, 4, '고3', 'math-a', 'advanced', 'https://parkhyosam.tistory.com/6266432', ARRAY[8,10,14]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20080415/mathga_hsj.pdf https://parkhyosam.tistory.com/6266432
('942300b9935abb7fce5dc1c7a9560364'::uuid, 2008, 4, '고3', 'math-b', 'semi', 'https://parkhyosam.tistory.com/6266432', ARRAY[4,5,6,7,8,9,16,17,18,19,22,24,26,27,29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20080415/mathga_hsj.pdf https://parkhyosam.tistory.com/6266432
('942300b9935abb7fce5dc1c7a9560364'::uuid, 2008, 4, '고3', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/6266432', ARRAY[10,12,14,15,21,23,25,28,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20080415/mathga_hsj.pdf https://parkhyosam.tistory.com/6266432
('942300b9935abb7fce5dc1c7a9560364'::uuid, 2008, 4, '고3', 'math-b', 'killer', 'https://parkhyosam.tistory.com/6266432', ARRAY[11,13,20]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20080919/mathga_hsj.pdf https://parkhyosam.tistory.com/6908867 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=63&sub_cod=2101&years=2008
('1585f292ee70237d6ad7c659df95e170'::uuid, 2008, 9, '고2', 'math-a', 'semi', 'https://parkhyosam.tistory.com/6908867', ARRAY[6,7,12,14,15,19,20,23,26,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20080919/mathga_hsj.pdf https://parkhyosam.tistory.com/6908867 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=63&sub_cod=2101&years=2008
('1585f292ee70237d6ad7c659df95e170'::uuid, 2008, 9, '고2', 'math-a', 'advanced', 'https://parkhyosam.tistory.com/6908867', ARRAY[13,18,21,24,25,28,29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20080919/mathga_hsj.pdf https://parkhyosam.tistory.com/6908867 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=63&sub_cod=2200&years=2008
('1585f292ee70237d6ad7c659df95e170'::uuid, 2008, 9, '고2', 'math-b', 'semi', 'https://parkhyosam.tistory.com/6908867', ARRAY[5,7,8,11,12,14,15,19,23,26]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20080919/mathga_hsj.pdf https://parkhyosam.tistory.com/6908867 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=63&sub_cod=2200&years=2008
('1585f292ee70237d6ad7c659df95e170'::uuid, 2008, 9, '고2', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/6908867', ARRAY[13,17,18,20,24,25,27,28,29,30]),
-- 2009학년도 온라인 가채점 분석표. 수리 가형 선택은 미분과 적분. https://www.newsprime.co.kr/data/photos/news/photo/200904/84003_36124_262.png
('fad68b3d4ccdc062c501262bcf3a80e8'::uuid, 2008, 11, '고3', 'math-a', 'semi', 'https://www.newsprime.co.kr/data/photos/news/photo/200904/84003_36124_262.png', ARRAY[1,2,3,4,8]),
-- 2009학년도 온라인 가채점 분석표. 수리 가형 선택은 미분과 적분. https://www.newsprime.co.kr/data/photos/news/photo/200904/84003_36124_262.png
('fad68b3d4ccdc062c501262bcf3a80e8'::uuid, 2008, 11, '고3', 'math-a', 'advanced', 'https://www.newsprime.co.kr/data/photos/news/photo/200904/84003_36124_262.png', ARRAY[19]),
-- 2009학년도 온라인 가채점 분석표. 수리 가형 선택은 미분과 적분. https://www.newsprime.co.kr/data/photos/news/photo/200904/84003_36124_262.png
('fad68b3d4ccdc062c501262bcf3a80e8'::uuid, 2008, 11, '고3', 'math-a', 'killer', 'https://www.newsprime.co.kr/data/photos/news/photo/200904/84003_36124_262.png', ARRAY[24,25]),
-- 2009학년도 온라인 가채점 분석표. 수리 가형 선택은 미분과 적분. https://www.newsprime.co.kr/data/photos/news/photo/200904/84003_36124_262.png
('fad68b3d4ccdc062c501262bcf3a80e8'::uuid, 2008, 11, '고3', 'math-a-integral', 'advanced', 'https://www.newsprime.co.kr/data/photos/news/photo/200904/84003_36124_262.png', ARRAY[28]),
-- 2009학년도 온라인 가채점 분석표. 수리 가형 선택은 미분과 적분. https://www.newsprime.co.kr/data/photos/news/photo/200904/84003_36124_262.png
('fad68b3d4ccdc062c501262bcf3a80e8'::uuid, 2008, 11, '고3', 'math-a-integral', 'killer', 'https://www.newsprime.co.kr/data/photos/news/photo/200904/84003_36124_262.png', ARRAY[30]),
-- 2009학년도 온라인 가채점 분석표. 수리 가형 선택은 미분과 적분. https://www.newsprime.co.kr/data/photos/news/photo/200904/84003_36124_262.png
('fad68b3d4ccdc062c501262bcf3a80e8'::uuid, 2008, 11, '고3', 'math-b', 'semi', 'https://www.newsprime.co.kr/data/photos/news/photo/200904/84003_36124_262.png', ARRAY[1,2,5,6,9]),
-- 2009학년도 온라인 가채점 분석표. 수리 가형 선택은 미분과 적분. https://www.newsprime.co.kr/data/photos/news/photo/200904/84003_36124_262.png
('fad68b3d4ccdc062c501262bcf3a80e8'::uuid, 2008, 11, '고3', 'math-b', 'advanced', 'https://www.newsprime.co.kr/data/photos/news/photo/200904/84003_36124_262.png', ARRAY[11]),
-- 2009학년도 온라인 가채점 분석표. 수리 가형 선택은 미분과 적분. https://www.newsprime.co.kr/data/photos/news/photo/200904/84003_36124_262.png
('fad68b3d4ccdc062c501262bcf3a80e8'::uuid, 2008, 11, '고3', 'math-b', 'killer', 'https://www.newsprime.co.kr/data/photos/news/photo/200904/84003_36124_262.png', ARRAY[21,22,25,29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090311/math_hsj.pdf https://parkhyosam.tistory.com/7088604
('1c80b1bc51acd435f5a16480c193bb70'::uuid, 2009, 3, '고1', 'math', 'semi', 'https://parkhyosam.tistory.com/7088604', ARRAY[8,9,10,11,12,16,17,21,23,24,25,26,27]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090311/math_hsj.pdf https://parkhyosam.tistory.com/7088604
('1c80b1bc51acd435f5a16480c193bb70'::uuid, 2009, 3, '고1', 'math', 'advanced', 'https://parkhyosam.tistory.com/7088604', ARRAY[15,19,20,28,29,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090312/math_hsj.pdf https://parkhyosam.tistory.com/7088607
('0f38e8d0912a236cf46e1c4912b123e9'::uuid, 2009, 3, '고2', 'math-a', 'advanced', 'https://parkhyosam.tistory.com/7088607', ARRAY[5,12,14,18,19,20,21,25,26,27,28,29,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090312/math_hsj.pdf https://parkhyosam.tistory.com/7088607
('0f38e8d0912a236cf46e1c4912b123e9'::uuid, 2009, 3, '고2', 'math-a', 'semi', 'https://parkhyosam.tistory.com/7088607', ARRAY[6,8,9,10,11,13,15,16,17,23,24]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090313/mathna_hsj.pdf https://parkhyosam.tistory.com/7088608
('8f3075e10847524e2af8c3336066543a'::uuid, 2009, 3, '고3', 'math-b', 'semi', 'https://parkhyosam.tistory.com/7088608', ARRAY[3,5,7,9,11,13,14,16,17,19,20,26,27,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090313/mathna_hsj.pdf https://parkhyosam.tistory.com/7088608
('8f3075e10847524e2af8c3336066543a'::uuid, 2009, 3, '고3', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/7088608', ARRAY[6,8,10,12,15,21,22,23,24,28,29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090313/mathna_hsj.pdf https://parkhyosam.tistory.com/7088608
('8f3075e10847524e2af8c3336066543a'::uuid, 2009, 3, '고3', 'math-b', 'killer', 'https://parkhyosam.tistory.com/7088608', ARRAY[25]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090617/math_hsj.pdf https://parkhyosam.tistory.com/7088662
('dcc8c750c6dbc8fdc5f5266b537caac7'::uuid, 2009, 6, '고1', 'math', 'semi', 'https://parkhyosam.tistory.com/7088662', ARRAY[3,7,8,9,10,11,12,13,15,16,18,19,20,22,23,24,25]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090617/math_hsj.pdf https://parkhyosam.tistory.com/7088662
('dcc8c750c6dbc8fdc5f5266b537caac7'::uuid, 2009, 6, '고1', 'math', 'advanced', 'https://parkhyosam.tistory.com/7088662', ARRAY[14,17,21,26,28,29,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090617/math_hsj.pdf https://parkhyosam.tistory.com/7088662
('dcc8c750c6dbc8fdc5f5266b537caac7'::uuid, 2009, 6, '고1', 'math', 'killer', 'https://parkhyosam.tistory.com/7088662', ARRAY[27]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090618/mathga_hsj.pdf https://parkhyosam.tistory.com/7088659 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=75&sub_cod=2101&years=2009
('517a946ba92bfbed4f61d9fa9fa79d58'::uuid, 2009, 6, '고2', 'math-a', 'semi', 'https://parkhyosam.tistory.com/7088659', ARRAY[6,9,12,13,14,15,16,17,18,20,21,22,23,24,25,26]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090618/mathga_hsj.pdf https://parkhyosam.tistory.com/7088659 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=75&sub_cod=2101&years=2009
('517a946ba92bfbed4f61d9fa9fa79d58'::uuid, 2009, 6, '고2', 'math-a', 'advanced', 'https://parkhyosam.tistory.com/7088659', ARRAY[8,11,19,27,28,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090618/mathga_hsj.pdf https://parkhyosam.tistory.com/7088659 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=75&sub_cod=2101&years=2009
('517a946ba92bfbed4f61d9fa9fa79d58'::uuid, 2009, 6, '고2', 'math-a', 'killer', 'https://parkhyosam.tistory.com/7088659', ARRAY[29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090618/mathga_hsj.pdf https://parkhyosam.tistory.com/7088659 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=75&sub_cod=2200&years=2009
('517a946ba92bfbed4f61d9fa9fa79d58'::uuid, 2009, 6, '고2', 'math-b', 'semi', 'https://parkhyosam.tistory.com/7088659', ARRAY[2,4,5,6,7,10,12,13,16,17,21,22,26]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/7088622 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=74&sub_cod=2200&years=2009
('7374c33ce97e060eb3175d2ce190b055'::uuid, 2009, 6, '고3', 'math-b', 'semi', 'https://parkhyosam.tistory.com/7088622', ARRAY[4,8,11,12,13,17,18,20,21,26,28,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090618/mathga_hsj.pdf https://parkhyosam.tistory.com/7088659 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=75&sub_cod=2200&years=2009
('517a946ba92bfbed4f61d9fa9fa79d58'::uuid, 2009, 6, '고2', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/7088659', ARRAY[8,9,11,14,15,18,19,20,23,24,25,27,28,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/7088622 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=74&sub_cod=2200&years=2009
('7374c33ce97e060eb3175d2ce190b055'::uuid, 2009, 6, '고3', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/7088622', ARRAY[9,10,14,16,22,23,24,27]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 발행처 원표와 30개 정답 일치. https://parkhyosam.tistory.com/7088622 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=74&sub_cod=2200&years=2009
('7374c33ce97e060eb3175d2ce190b055'::uuid, 2009, 6, '고3', 'math-b', 'killer', 'https://parkhyosam.tistory.com/7088622', ARRAY[25]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090618/mathga_hsj.pdf https://parkhyosam.tistory.com/7088659 | 보관본과 30개 정답이 일치하는 발행처 원표. https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=75&sub_cod=2200&years=2009
('517a946ba92bfbed4f61d9fa9fa79d58'::uuid, 2009, 6, '고2', 'math-b', 'killer', 'https://parkhyosam.tistory.com/7088659', ARRAY[29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090714/mathga_hsj.pdf https://parkhyosam.tistory.com/7088637
('efc89533bbd9c050575ab263aea2edd7'::uuid, 2009, 7, '고3', 'math-b', 'semi', 'https://parkhyosam.tistory.com/7088637', ARRAY[4,6,7,9,11,12,13,16,18,22,29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090714/mathga_hsj.pdf https://parkhyosam.tistory.com/7088637
('efc89533bbd9c050575ab263aea2edd7'::uuid, 2009, 7, '고3', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/7088637', ARRAY[8,14,15,17,19,20,21,23,26,27,28,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090714/mathga_hsj.pdf https://parkhyosam.tistory.com/7088637
('efc89533bbd9c050575ab263aea2edd7'::uuid, 2009, 7, '고3', 'math-b', 'killer', 'https://parkhyosam.tistory.com/7088637', ARRAY[24,25]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090917/math_hsj.pdf https://parkhyosam.tistory.com/7088663
('8cbcf171381c71f4bbca71936eb60833'::uuid, 2009, 9, '고1', 'math', 'semi', 'https://parkhyosam.tistory.com/7088663', ARRAY[3,5,9,11,13,15,17,19,21,23,26]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090917/math_hsj.pdf https://parkhyosam.tistory.com/7088663
('8cbcf171381c71f4bbca71936eb60833'::uuid, 2009, 9, '고1', 'math', 'advanced', 'https://parkhyosam.tistory.com/7088663', ARRAY[6,10,12,16,20,24,25,27,28,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090917/math_hsj.pdf https://parkhyosam.tistory.com/7088663
('8cbcf171381c71f4bbca71936eb60833'::uuid, 2009, 9, '고1', 'math', 'killer', 'https://parkhyosam.tistory.com/7088663', ARRAY[18,29]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090918/mathga_hsj.pdf https://parkhyosam.tistory.com/7088661
('1474c17fa73f16f19bfe69a9cfc93310'::uuid, 2009, 9, '고2', 'math-a', 'semi', 'https://parkhyosam.tistory.com/7088661', ARRAY[6,10,16,17,19,21,23,24,25,26,27]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090918/mathga_hsj.pdf https://parkhyosam.tistory.com/7088661
('1474c17fa73f16f19bfe69a9cfc93310'::uuid, 2009, 9, '고2', 'math-a', 'advanced', 'https://parkhyosam.tistory.com/7088661', ARRAY[12,14,20,28,29,30]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090918/mathga_hsj.pdf https://parkhyosam.tistory.com/7088661
('1474c17fa73f16f19bfe69a9cfc93310'::uuid, 2009, 9, '고2', 'math-b', 'semi', 'https://parkhyosam.tistory.com/7088661', ARRAY[5,6,7,8,9,10,11,14,16,19,20,23,25,26]),
-- 시험 당시에 보관된 학년·월·유형별 30문항 분석표. 정답 순서 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20090918/mathga_hsj.pdf https://parkhyosam.tistory.com/7088661
('1474c17fa73f16f19bfe69a9cfc93310'::uuid, 2009, 9, '고2', 'math-b', 'advanced', 'https://parkhyosam.tistory.com/7088661', ARRAY[12,17,18,21,24,27,28,29,30]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20091015/mathna_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=83&sub_cod=2200&years=2009
('ff0abf7e48baafbfab37bb4cb7dce38e'::uuid, 2009, 10, '고3', 'math-b', 'semi', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=83&sub_cod=2200&years=2009', ARRAY[5,7,8,10,12,13,14,18,19,22,26,27,28,29,30]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20091015/mathna_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=83&sub_cod=2200&years=2009
('ff0abf7e48baafbfab37bb4cb7dce38e'::uuid, 2009, 10, '고3', 'math-b', 'advanced', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=83&sub_cod=2200&years=2009', ARRAY[9,11,15,16,17,20,21,23,24]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20091015/mathna_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=83&sub_cod=2200&years=2009
('ff0abf7e48baafbfab37bb4cb7dce38e'::uuid, 2009, 10, '고3', 'math-b', 'killer', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=83&sub_cod=2200&years=2009', ARRAY[25]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20091112/mathga1_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=85&sub_cod=2101&years=2010
('1cc758d0b25db12e831d33e21065d44d'::uuid, 2009, 11, '고3', 'math-a', 'semi', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=85&sub_cod=2101&years=2010', ARRAY[4,11,14,15,16,17,20,22,23]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20091117/mathga_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=86&sub_cod=2101&years=2009
('41b11188131fba6d663147e192c38908'::uuid, 2009, 11, '고2', 'math-a', 'semi', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=86&sub_cod=2101&years=2009', ARRAY[5,6,9,10,11,13,14,15,16,17,18,19,20,21,24,29]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20091117/mathga_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=86&sub_cod=2101&years=2009
('41b11188131fba6d663147e192c38908'::uuid, 2009, 11, '고2', 'math-a', 'advanced', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=86&sub_cod=2101&years=2009', ARRAY[8,22,25,26,27,28,30]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20091112/mathga1_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=85&sub_cod=2101&years=2010
('1cc758d0b25db12e831d33e21065d44d'::uuid, 2009, 11, '고3', 'math-a', 'advanced', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=85&sub_cod=2101&years=2010', ARRAY[8,21,24]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20091112/mathga1_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=85&sub_cod=2101&years=2010
('1cc758d0b25db12e831d33e21065d44d'::uuid, 2009, 11, '고3', 'math-a', 'killer', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=85&sub_cod=2101&years=2010', ARRAY[25]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20091112/mathga1_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=85&sub_cod=2101&years=2010
('1cc758d0b25db12e831d33e21065d44d'::uuid, 2009, 11, '고3', 'math-a-integral', 'semi', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=85&sub_cod=2101&years=2010', ARRAY[27,28]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20091112/mathga1_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=85&sub_cod=2101&years=2010
('1cc758d0b25db12e831d33e21065d44d'::uuid, 2009, 11, '고3', 'math-a-integral', 'advanced', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=85&sub_cod=2101&years=2010', ARRAY[29,30]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20091117/mathga_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=86&sub_cod=2200&years=2009
('41b11188131fba6d663147e192c38908'::uuid, 2009, 11, '고2', 'math-b', 'semi', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=86&sub_cod=2200&years=2009', ARRAY[4,5,6,7,9,10,12,13,14,15,16,17,18,19,21,22,23,26,30]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20091117/mathga_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=86&sub_cod=2200&years=2009
('41b11188131fba6d663147e192c38908'::uuid, 2009, 11, '고2', 'math-b', 'advanced', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=86&sub_cod=2200&years=2009', ARRAY[8,24,25,27,28,29]),
-- 수능 당일 분석에서 고난도·신유형으로 지목. 로그 그래프와 직선의 교점이 만족하는 조건을 보기별로 검증한다. https://www.yna.co.kr/view/AKR20091112211500004
('1cc758d0b25db12e831d33e21065d44d'::uuid, 2009, 11, '고3', 'math-b', 'advanced', 'https://www.yna.co.kr/view/AKR20091112211500004', ARRAY[16]),
-- 수능 당일 분석에서 고난도·신유형으로 지목. 도형 성질과 수열의 극한을 결합한다. https://www.yna.co.kr/view/AKR20091112211500004
('1cc758d0b25db12e831d33e21065d44d'::uuid, 2009, 11, '고3', 'math-b', 'advanced', 'https://www.yna.co.kr/view/AKR20091112211500004', ARRAY[25]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100312/mathga_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=88&sub_cod=2101&years=2010
('f8cbd49ffa0e48f761c9654864c7d98e'::uuid, 2010, 3, '고3', 'math-a', 'semi', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=88&sub_cod=2101&years=2010', ARRAY[4,6,8,11,12,13,14,15,16,17,18,19,20,25,27,30]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100312/mathga_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=88&sub_cod=2101&years=2010
('f8cbd49ffa0e48f761c9654864c7d98e'::uuid, 2010, 3, '고3', 'math-a', 'advanced', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=88&sub_cod=2101&years=2010', ARRAY[10,21,22,23,24,28,29]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100312/mathga_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=88&sub_cod=2200&years=2010
('f8cbd49ffa0e48f761c9654864c7d98e'::uuid, 2010, 3, '고3', 'math-b', 'semi', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=88&sub_cod=2200&years=2010', ARRAY[5,7,8,9,11,12,14,15,17,18,19,22,23,25,26,27,28]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100312/mathga_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=88&sub_cod=2200&years=2010
('f8cbd49ffa0e48f761c9654864c7d98e'::uuid, 2010, 3, '고3', 'math-b', 'advanced', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=88&sub_cod=2200&years=2010', ARRAY[10,13,16,20,21,24,29,30]),
-- 문항 정답 순서 25개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100413/mathga_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=91&sub_cod=2101&years=2010
('566389c29b8608325ac595ee2fdfb868'::uuid, 2010, 4, '고3', 'math-a', 'semi', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=91&sub_cod=2101&years=2010', ARRAY[3,4,9,10,11,13,14,15,18,21,22,25]),
-- 문항 정답 순서 25개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100413/mathga_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=91&sub_cod=2101&years=2010
('566389c29b8608325ac595ee2fdfb868'::uuid, 2010, 4, '고3', 'math-a', 'advanced', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=91&sub_cod=2101&years=2010', ARRAY[12,17,20,23,24]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100617/mathga_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=95&sub_cod=2101&years=2010
('51b246c2798366c7d24a25fd2fcf942c'::uuid, 2010, 6, '고2', 'math-a', 'semi', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=95&sub_cod=2101&years=2010', ARRAY[5,6,10,14,15,16,17,19,20,23,24,25,27]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100617/mathga_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=95&sub_cod=2101&years=2010
('51b246c2798366c7d24a25fd2fcf942c'::uuid, 2010, 6, '고2', 'math-a', 'advanced', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=95&sub_cod=2101&years=2010', ARRAY[7,8,9,11,12,21,28,29,30]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100617/mathga_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=95&sub_cod=2101&years=2010
('51b246c2798366c7d24a25fd2fcf942c'::uuid, 2010, 6, '고2', 'math-a', 'killer', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=95&sub_cod=2101&years=2010', ARRAY[26]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100617/mathna_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=95&sub_cod=2200&years=2010
('51b246c2798366c7d24a25fd2fcf942c'::uuid, 2010, 6, '고2', 'math-b', 'semi', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=95&sub_cod=2200&years=2010', ARRAY[4,8,10,13,14,23,28]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100617/mathna_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=95&sub_cod=2200&years=2010
('51b246c2798366c7d24a25fd2fcf942c'::uuid, 2010, 6, '고2', 'math-b', 'advanced', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=95&sub_cod=2200&years=2010', ARRAY[5,6,7,9,11,12,15,16,19,20,21,24,25]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100617/mathna_hsj.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=95&sub_cod=2200&years=2010
('51b246c2798366c7d24a25fd2fcf942c'::uuid, 2010, 6, '고2', 'math-b', 'killer', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=95&sub_cod=2200&years=2010', ARRAY[17,26,27,29,30]),
-- 문항 정답 순서 25개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100708/mathga_hsj_1.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=97&sub_cod=2101&years=2010
('e4ffe51da2157229be72ae8e6d653ab1'::uuid, 2010, 7, '고3', 'math-a', 'semi', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=97&sub_cod=2101&years=2010', ARRAY[7,9,11,12,13,15,16,19,21]),
-- 문항 정답 순서 25개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100708/mathga_hsj_1.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=97&sub_cod=2101&years=2010
('e4ffe51da2157229be72ae8e6d653ab1'::uuid, 2010, 7, '고3', 'math-a', 'advanced', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=97&sub_cod=2101&years=2010', ARRAY[17,20,22,24,25]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100708/mathna_hsj_1.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=97&sub_cod=2200&years=2010
('e4ffe51da2157229be72ae8e6d653ab1'::uuid, 2010, 7, '고3', 'math-b', 'semi', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=97&sub_cod=2200&years=2010', ARRAY[6,8,9,10,12,13,14,15,16,17,20,27,28]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100708/mathna_hsj_1.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=97&sub_cod=2200&years=2010
('e4ffe51da2157229be72ae8e6d653ab1'::uuid, 2010, 7, '고3', 'math-b', 'advanced', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=97&sub_cod=2200&years=2010', ARRAY[7,11,21,23,30]),
-- 문항 정답 순서 30개와 발행처 유형 코드 대조 | EBSi https://wdown.ebsi.co.kr/W61001/01exam/20100708/mathna_hsj_1.pdf https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=97&sub_cod=2200&years=2010
('e4ffe51da2157229be72ae8e6d653ab1'::uuid, 2010, 7, '고3', 'math-b', 'killer', 'https://www.megastudy.net/Entinfo/pda/User_Ans_Anal.asp?seq=97&sub_cod=2200&years=2010', ARRAY[22,25]),
-- 메가스터디 2011학년도 해설, PDF 5쪽 표 I-2·I-3. 오답률 방향 확인. https://file.megastudy.net/FileServer/entinfo/Explain/2011_0131/20110131_ch_1.pdf#page=5
('1327cf0eedf0a2c172abb5c3b77db210'::uuid, 2010, 11, '고3', 'math-a', 'advanced', 'https://file.megastudy.net/FileServer/entinfo/Explain/2011_0131/20110131_ch_1.pdf#page=5', ARRAY[11,15,16,17]),
-- 메가스터디 2011학년도 해설, PDF 5쪽 표 I-2·I-3. 오답률 방향 확인. https://file.megastudy.net/FileServer/entinfo/Explain/2011_0131/20110131_ch_1.pdf#page=5
('1327cf0eedf0a2c172abb5c3b77db210'::uuid, 2010, 11, '고3', 'math-a-integral', 'killer', 'https://file.megastudy.net/FileServer/entinfo/Explain/2011_0131/20110131_ch_1.pdf#page=5', ARRAY[28]),
-- 메가스터디 2011학년도 해설, PDF 5쪽 표 I-2·I-3. 오답률 방향 확인. https://file.megastudy.net/FileServer/entinfo/Explain/2011_0131/20110131_ch_1.pdf#page=5
('1327cf0eedf0a2c172abb5c3b77db210'::uuid, 2010, 11, '고3', 'math-b', 'semi', 'https://file.megastudy.net/FileServer/entinfo/Explain/2011_0131/20110131_ch_1.pdf#page=5', ARRAY[12,14,17]),
-- 메가스터디 2011학년도 해설, PDF 5쪽 표 I-2·I-3. 오답률 방향 확인. https://file.megastudy.net/FileServer/entinfo/Explain/2011_0131/20110131_ch_1.pdf#page=5
('1327cf0eedf0a2c172abb5c3b77db210'::uuid, 2010, 11, '고3', 'math-b', 'advanced', 'https://file.megastudy.net/FileServer/entinfo/Explain/2011_0131/20110131_ch_1.pdf#page=5', ARRAY[15,16])
) as source(session_id,year,month,grade,section,level,source_url,numbers);
alter table review_input add primary key(session_id,section,n);
create temp table review_match on commit drop as
select p.id as problem_id,i.*,q.variant
from review_input i
join public.exam_sessions s on (s.id,s.calendar_year,s.month,s.grade)=(i.session_id,i.year,i.month,i.grade)
join public.exam_questions q on (q.session_id,q.section,q.question_no)=(i.session_id,i.section,i.n)
join public.problems p on p.exam_question_id=q.id and p.public and not p.withdrawn;
alter table review_match add primary key(problem_id);
do $$ begin
 if (select count(*) from review_match where variant<>'even')<>1083
 or (select count(*) from review_match)<>1167
 or exists(select 1 from review_input where year not between 1993 and 2010)
 then raise exception 'Archive review catalog mismatch'; end if;
end $$;
lock table public.problem_difficulties in share row exclusive mode;
create temp table reviewed_years_with_rates on commit drop as
select distinct s.calendar_year from public.problem_difficulties d
join public.problems p on p.id=d.problem_id and p.public and not p.withdrawn
join public.exam_questions q on q.id=p.exam_question_id
join public.exam_sessions s on s.id=q.session_id
where d.correct_rate is not null and s.calendar_year between 1993 and 2010;
insert into public.problem_difficulties(problem_id,level,classification_method,source_url,rule_version)
select problem_id,level,'manual',source_url,'archive-difficulty-review-v1'
from review_match m where not exists(select 1 from reviewed_years_with_rates y where y.calendar_year=m.year)
on conflict(problem_id) do nothing;
select count(*) filter(where m.variant<>'even') as displayed, count(*) as records,
 count(d.correct_rate) as stored_rates
from review_match m join public.problem_difficulties d using (problem_id)
where (d.rule_version,d.level,d.source_url)=('archive-difficulty-review-v1',m.level,m.source_url);
commit;

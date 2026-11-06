const clean=v=>typeof v==='string'?v.replace(/\s+/g,' ').trim():'';
const num=(v,min=1,max=9999)=>Number.isInteger(Number(v))&&Number(v)>=min&&Number(v)<=max?Number(v):null;
const sections={common:'공통',probability:'확률과 통계',calculus:'미적분',geometry:'기하',math:''};
const aliases={'공통수학1':'공수1','공통수학2':'공수2','수학Ⅰ':'수1','수학Ⅱ':'수2','확률과 통계':'확통','미적분':'미적','기하':'기하'};
export function normalizeIdentity(value={}){
 const i={};for(const key of ['kind','school','grade','subject','book','course','edition','provider','section'])if(clean(value[key]))i[key]=clean(value[key]).slice(0,100);
 for(const [key,min,max]of [['year',2000,2100],['month',1,12],['number',1,9999],['semester',1,2],['exam',1,4],['page',1,9999]]){const n=num(value[key],min,max);if(n)i[key]=n;}
 return i;
}
export function inferSourceIdentity(problem={},override){
 const details=problem.sourceDetails||problem.source_details||problem.examDetails||{},c=problem.classification||details.classification||details;
 const explicit=normalizeIdentity(override?.kind?override:details.identity||{});if(explicit.kind)return explicit;
 const text=[clean(problem.title),clean(problem.sourceLabel||details.label)].join(' '),source=problem.source||'',number=num(c.question_no)||num(text.match(/(?:^|\s)(\d{1,4})\s*번/)?.[1]),year=num(c.calendar_year,2000,2100)||num(text.match(/(20\d{2})\s*년(?!도)/)?.[1],2000,2100);
 const provider=/수능/.test(text)||source==='수능'?'수능':/평가원/.test(text)||source==='평가원'?'평가원':/교육청/.test(text)||source==='교육청'?'교육청':'';
 if(provider&&year&&number){const month=provider==='수능'?11:num(c.month,1,12)||num(text.match(/(\d{1,2})\s*월/)?.[1],1,12);if(month)return normalizeIdentity({kind:'exam',provider,year,month,number,grade:problem.grade||c.grade||(problem.examQuestionId||problem.exam_question_id?'고3':''),section:c.section||Object.keys(sections).find(k=>sections[k]&&text.includes(sections[k])),subject:'수학'});}
 if(source==='내신'||/학기\s*(?:중간|기말)/.test(text)){
 const school=clean(text.match(/([가-힣A-Za-z0-9]+(?:고등학교|중학교|고|중))(?=\s|$)/)?.[1]),grade=problem.grade||text.match(/([중고][123])/)?.[1]||text.match(/([123])학년/)?.[1],semester=num(text.match(/([12])\s*학기/)?.[1],1,2),phase=/기말/.test(text)?2:/중간/.test(text)?1:null;
 return normalizeIdentity({kind:'school',school,year,grade,semester,exam:semester&&phase?(semester-1)*2+phase:null,subject:problem.subject||'수학',number});
 }
 if(source==='교재'||/쎈|정석|마플|개념원리/.test(text)){
 const course=Object.keys(aliases).find(x=>text.replaceAll(' ','').includes(x.replaceAll(' ','')))||'',book=clean(text.match(/(라이트쎈|베이직쎈|쎈|개념원리|수학의 정석|마플|수능특강|수능완성)/)?.[1]);
 return normalizeIdentity({kind:'book',book,course,number,page:num(text.match(/(?:p\.?\s*|페이지\s*)(\d+)/i)?.[1]||text.match(/(\d+)\s*쪽/)?.[1]),edition:details.edition});
 }
 return {};
}
export function sourceNames(value){
 const i=normalizeIdentity(value),n=i.number;let long='',code='';
 if(i.kind==='exam'&&i.provider&&i.year&&i.month&&n){const section=sections[i.section]||'',exam=i.provider==='수능'?'수능':`${i.month}월 ${i.provider}`;
  long=[`${i.year}년`,i.provider==='수능'?'':`${i.month}월`,i.grade,i.provider,'수학',section,`${n}번`].filter(Boolean).join(' ');
  code=`${i.provider} ${String(i.year).slice(-2)}${String(i.month).padStart(2,'0')}${String(n).padStart(2,'0')}`;
  if(section&&i.section!=='common')code+=' '+(aliases[section]||section);if(i.provider==='교육청'&&i.grade)code+=' '+i.grade;
 }else if(i.kind==='school'&&i.school&&i.year&&i.grade&&i.exam&&n){const grade=num(String(i.grade).match(/[123]/)?.[0],1,3),semester=Math.ceil(i.exam/2),phase=i.exam%2?'중간고사':'기말고사';
  if(grade){long=`${i.school} ${i.year}년 ${grade}학년 ${semester}학기 ${phase} ${i.subject||'수학'} ${n}번`;code=`${i.school} ${String(i.year).slice(-2)}${grade}${i.exam}${String(n).padStart(2,'0')}`;}
 }else if(i.kind==='book'&&i.book&&i.course&&n){long=[i.book,i.course,i.page?`${i.page}쪽`:'',`${n}번`].filter(Boolean).join(' ');code=[i.book,aliases[i.course]||i.course,i.page?`p${i.page}`:'',String(n)].filter(Boolean).join(' ');}
 return {long,code,edition:i.edition||''};
}
export function standardSolutionTitle(problem={},override){const {long,code}=sourceNames(inferSourceIdentity(problem,override));return long?`${long} 손풀이${code?' ('+code+')':''}`:'';}
export function boundedTitle(title,limit=85){if(title.length<=limit)return title;const match=title.match(/ (\([^()]+\))$/);return match&&match[0].length<limit-10?title.slice(0,limit-match[0].length-1)+'…'+match[0]:title.slice(0,limit);}

const problemFields='id,exam_question_id,calendar_year:source_details->classification->>calendar_year,month:source_details->classification->>month,section:source_details->classification->>section,question_no:source_details->classification->>question_no,variant:source_details->classification->>variant';
const cacheHeaders={'Content-Type':'application/json; charset=utf-8','X-Content-Type-Options':'nosniff','Cache-Control':'public, max-age=0, s-maxage=60, stale-while-revalidate=300'};

// Matches examQuestionGroup: only complete November odd/even identities collapse.
function examKey(problem){
 if(problem.exam_question_id&&['odd','even'].includes(problem.variant)&&Number(problem.month)===11
  &&Number.isInteger(Number(problem.calendar_year))&&Number(problem.calendar_year)>0
  &&Number.isInteger(Number(problem.question_no))&&Number(problem.question_no)>0&&problem.section){
  return JSON.stringify([Number(problem.calendar_year),11,problem.section,Number(problem.question_no)]);
 }
 return 'problem:'+problem.id;
}

export function createNavigationCountsHandler({backendUrl,key,fetcher=fetch,now=()=>Date.now()}={}){
 async function rows(table,select,order,filters={}){
  const page=async(offset,limit)=>{
   const url=new URL('/rest/v1/'+table,backendUrl);
   for(const [name,value]of Object.entries({select,order,limit,offset,...filters}))url.searchParams.set(name,String(value));
   // Counts are public. Never forward browser Authorization or cookies here.
   const response=await fetcher(url,{headers:{apikey:key,Prefer:'count=exact'},signal:AbortSignal.timeout(10000),cache:'no-store'});
   if(!response.ok)throw Error('COUNT_READ_FAILED');
   const data=await response.json();if(!Array.isArray(data))throw Error('COUNT_READ_INVALID');
   const totalText=response.headers.get('content-range')?.split('/').at(-1);
   const total=/^\d+$/.test(totalText||'')?Number(totalText):null;
   return {data,total};
  };
  const first=await page(0,1000),result=[...first.data];
  if(Number.isSafeInteger(first.total)){
   if(first.total===0)return result;
   if(!first.data.length)throw Error('COUNT_READ_INCOMPLETE');
   // PostgREST may enforce a smaller row cap. Advance by what actually arrived.
   const size=Math.min(1000,first.data.length);
   for(let offset=size;offset<first.total;offset+=size*4){
    const offsets=Array.from({length:Math.min(4,Math.ceil((first.total-offset)/size))},(_,i)=>offset+i*size);
    const pages=await Promise.all(offsets.map(start=>page(start,size)));
    for(const next of pages){if(!next.data.length)throw Error('COUNT_READ_INCOMPLETE');result.push(...next.data);}
   }
   if(result.length<first.total)throw Error('COUNT_READ_INCOMPLETE');
   return result;
  }
  // A proxy without Content-Range must not turn its row cap into a false total.
  for(let offset=result.length;first.data.length;){
   const next=await page(offset,1000);if(!next.data.length)return result;
   result.push(...next.data);offset+=next.data.length;
  }
  return result;
 }
 return async request=>{
  if(request?.method&&request.method!=='GET')return Response.json({error:'METHOD_NOT_ALLOWED'},{status:405,headers:{...cacheHeaders,'Cache-Control':'no-store',Allow:'GET'}});
  try{
   if(!backendUrl||!key)throw Error('COUNT_CONFIG_MISSING');
   const [problems,solutions,requests,uploaded]=await Promise.all([
    rows('problems',problemFields,'id',{public:'eq.true',withdrawn:'eq.false'}),
    rows('solutions','id,problem_id','id',{public:'eq.true'}),
    rows('solution_requests','id,problem_id','id'),
    rows('uploaded_exam_questions','problem_id','problem_id')
   ]);
   const publicIds=new Set(problems.map(p=>p.id));
   const solvedIds=new Set(solutions.filter(s=>publicIds.has(s.problem_id)).map(s=>s.problem_id));
   const requestIds=new Set(requests.filter(r=>publicIds.has(r.problem_id)).map(r=>r.id));
   const uploadedIds=new Set(uploaded.map(q=>q.problem_id));
   const examIds=new Set(problems.filter(p=>p.exam_question_id||uploadedIds.has(p.id)).map(examKey));
   return Response.json({feed:solvedIds.size+requestIds.size,exams:examIds.size,generatedAt:new Date(now()).toISOString()},{headers:cacheHeaders});
  }catch{
   return Response.json({error:'COUNTS_UNAVAILABLE'},{status:503,headers:{...cacheHeaders,'Cache-Control':'no-store'}});
  }
 };
}

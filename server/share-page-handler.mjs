const site='https://daechiskills.vercel.app';
const esc=s=>String(s??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
export function shareMetaTitle(nickname,title){return `[${String(nickname||'익명').slice(0,25)} 손풀이] ${String(title||'손풀이').slice(0,160)}`;}
export function createSharePageHandler({shell,fetcher=fetch,backendUrl='https://vxaysykigrocaymtlunz.supabase.co'}={}){
 return async request=>{
  const headers={'Content-Type':'text/html; charset=utf-8','Cache-Control':'private, no-store','X-Robots-Tag':'noindex, nofollow, noarchive','Referrer-Policy':'no-referrer','X-Content-Type-Options':'nosniff'};
  const token=new URL(request.url).searchParams.get('token');
  let meta=null,status=404;
  if(/^[a-f0-9]{64}$/.test(token||''))try{
   const response=await fetcher(backendUrl+'/functions/v1/archive-share',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({token,action:'preview'}),signal:AbortSignal.timeout(8000),cache:'no-store'});
   if(response.ok){const value=await response.json();if(typeof value.title==='string'&&typeof value.nickname==='string'&&['image','pdf'].includes(value.kind)){meta=value;status=200;}}
  }catch{status=503;}
  const title=meta?shareMetaTitle(meta.nickname,meta.title):'공유가 종료된 손풀이 · 대치스킬스';
  const description=meta?'공유받은 '+(meta.kind==='pdf'?'손풀이 PDF':'손풀이')+'를 대치스킬스에서 확인하세요.':'링크가 만료되었거나 공유가 중지되었어요.';
  const url=meta?site+'/s/'+token:site;
  // Do not embed any solution body, original file, private image or account ID.
  let html=shell.replace(/<title>[\s\S]*?<\/title>/,()=>'<title>'+esc(title)+'</title>');
  const values={'description':description,'og:title':title,'og:description':description,'og:url':url,'twitter:title':title,'twitter:description':description};
  html=html.replace(/<meta (name|property)="([^"]+)" content="[^"]*"\s*\/>/g,(tag,attr,key)=>key in values?`<meta ${attr}="${key}" content="${esc(values[key])}" />`:tag);
  html=html.replace(/<link rel="canonical" href="[^"]*"\s*\/>/,()=>'<link rel="canonical" href="'+esc(url)+'" />');
  html=html.replace('</head>','<meta name="robots" content="noindex,nofollow,noarchive" /><meta name="referrer" content="no-referrer" /></head>');
  return new Response(html,{status,headers});
 };
}

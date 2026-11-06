// On-demand reader transport. No files, images, or PDF bytes are persisted.
import {officialFiles} from './official-files.mjs';
export function createDocumentHandler({fetcher=fetch}={}){
 return async request=>{
  const error=(status,message)=>Response.json({error:message},{status,headers:{'Cache-Control':'no-store'}});
  if(request.method!=='GET')return error(405,'METHOD_NOT_ALLOWED');
  if(request.headers.get('sec-fetch-site')==='cross-site')return error(403,'ORIGIN_NOT_ALLOWED');
  const file=new URL(request.url).searchParams.get('file');
  if(!officialFiles.has(file))return error(404,'UNKNOWN_OFFICIAL_PAPER');
  const controller=new AbortController(),timeout=setTimeout(()=>controller.abort(),20000);
  try{
   const response=await fetcher('https://www.suneung.re.kr/boardCnts/fileDown.do?fileSeq='+file,{signal:controller.signal,redirect:'error',headers:{Accept:'application/pdf'}});
   if(!response.ok||!response.headers.get('content-type')?.startsWith('application/pdf'))return error(502,'OFFICIAL_DOCUMENT_UNAVAILABLE');
   if(Number(response.headers.get('content-length')||0)>4000000)return error(502,'DOCUMENT_TOO_LARGE');
   const reader=response.body.getReader(),chunks=[];let length=0;
   while(true){const {done,value}=await reader.read();if(done)break;length+=value.byteLength;if(length>4000000){await reader.cancel();return error(502,'DOCUMENT_TOO_LARGE');}chunks.push(value);}
   const bytes=new Uint8Array(length);let offset=0;for(const chunk of chunks){bytes.set(chunk,offset);offset+=chunk.byteLength;}
   if(new TextDecoder().decode(bytes.slice(0,5))!=='%PDF-')return error(502,'INVALID_DOCUMENT');
   return new Response(bytes,{headers:{'Content-Type':'application/pdf','Content-Length':String(length),'Cache-Control':'private, no-store','Content-Disposition':'inline; filename="official-exam.pdf"','X-Content-Type-Options':'nosniff','Cross-Origin-Resource-Policy':'same-origin'}});
  }catch{return error(502,'OFFICIAL_DOCUMENT_UNAVAILABLE');}finally{clearTimeout(timeout);}
 };
}

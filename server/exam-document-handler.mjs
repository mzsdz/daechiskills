// On-demand reader transport. No files, images, or PDF bytes are persisted.
import {officialFiles} from './official-files.mjs';
import {combinedCsatPapers,hostedExamDocuments} from '../shared/exam-documents.mjs';
export function createDocumentHandler({fetcher=fetch}={}){
 return async request=>{
  const error=(status,message)=>Response.json({error:message},{status,headers:{'Cache-Control':'no-store'}});
  if(request.method!=='GET')return error(405,'METHOD_NOT_ALLOWED');
  if(request.headers.get('sec-fetch-site')==='cross-site')return error(403,'ORIGIN_NOT_ALLOWED');
  const params=new URL(request.url).searchParams,file=params.get('file');
  if(!officialFiles.has(file)&&!hostedExamDocuments.has(file))return error(404,'UNKNOWN_OFFICIAL_PAPER');
  const form=params.get('form');
  const half=form==='odd'?combinedCsatPapers.get(file):null;
  if(form&&!half)return error(404,'UNKNOWN_PAPER_FORM');
  const controller=new AbortController(),timeout=setTimeout(()=>controller.abort(),20000);
  try{
   const url=hostedExamDocuments.get(file)??('https://www.suneung.re.kr/boardCnts/fileDown.do?fileSeq='+file);
   const response=await fetcher(url,{signal:controller.signal,redirect:'error',headers:{Accept:'application/pdf'}});
   const type=response.headers.get('content-type')?.split(';')[0];
   if(!response.ok||!(type==='application/pdf'||(hostedExamDocuments.has(file)&&type==='application/octet-stream')))return error(502,'OFFICIAL_DOCUMENT_UNAVAILABLE');
   if(Number(response.headers.get('content-length')||0)>4000000)return error(502,'DOCUMENT_TOO_LARGE');
   const reader=response.body.getReader(),chunks=[];let length=0;
   while(true){const {done,value}=await reader.read();if(done)break;length+=value.byteLength;if(length>4000000){await reader.cancel();return error(502,'DOCUMENT_TOO_LARGE');}chunks.push(value);}
   const bytes=new Uint8Array(length);let offset=0;for(const chunk of chunks){bytes.set(chunk,offset);offset+=chunk.byteLength;}
   if(new TextDecoder().decode(bytes.slice(0,5))!=='%PDF-')return error(502,'INVALID_DOCUMENT');
   let body=bytes,filename='official-exam.pdf';
   if(half){
    const {PDFDocument}=await import('pdf-lib');
    const archive=await PDFDocument.load(bytes);
    if(archive.getPageCount()!==half.oddPages*2)return error(502,'UNEXPECTED_PAPER_PAGE_COUNT');
    const odd=await PDFDocument.create();
    for(const page of await odd.copyPages(archive,Array.from({length:half.oddPages},(_,i)=>i)))odd.addPage(page);
    body=await odd.save();
    filename=`csat-${half.year+1}-math-odd.pdf`;
   }
   return new Response(body,{headers:{'Content-Type':'application/pdf','Content-Length':String(body.byteLength),'Cache-Control':'private, no-store','Content-Disposition':`inline; filename="${filename}"`,'X-Content-Type-Options':'nosniff','Cross-Origin-Resource-Policy':'same-origin'}});
  }catch{return error(502,'OFFICIAL_DOCUMENT_UNAVAILABLE');}finally{clearTimeout(timeout);}
 };
}

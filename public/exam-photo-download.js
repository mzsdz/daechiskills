document.addEventListener('click', async event => {
 const button=event.target.closest?.('button[data-exam-photo]');
 if(!button || button.disabled)return;
 const region=button.closest('.exam-viewer, .editorial-problem__section, [data-exam-photo-region]');
 const status=button.nextElementSibling;
 const image=region?.querySelector('img[data-exam-image], img.editorial-problem__image, img[data-exam-photo-source]');
 const rendered=region?.querySelector('.exam-question-canvas:not([hidden])');
 if(!image?.naturalWidth&&!rendered?.width){
  status.textContent='문제 사진을 표시한 뒤 다시 시도해 주세요.';
  return;
 }
 const page=location.href;
 button.disabled=true;
 status.textContent='';
 let copy;
 try{
  let canvas=rendered;
  if(!canvas?.width){
   copy=document.createElement('canvas');
   copy.width=image.naturalWidth;
   copy.height=image.naturalHeight;
   copy.getContext('2d').drawImage(image,0,0);
   canvas=copy;
  }
  const png=await new Promise(resolve=>canvas.toBlob(resolve,'image/png'));
  if(!png?.size||png.type!=='image/png')throw Error('Empty PNG');
  if(location.href!==page)return;
  const url=URL.createObjectURL(png);
  const link=document.createElement('a');
  link.href=url;
  link.download=button.dataset.examPhoto;
  document.body.append(link);
  link.click();
  link.remove();
  setTimeout(()=>URL.revokeObjectURL(url),60000);
 }catch{
  status.textContent='문제 사진을 내려받지 못했어요. 다시 시도해 주세요.';
 }finally{
  if(copy)copy.width=copy.height=0;
  button.disabled=false;
 }
});

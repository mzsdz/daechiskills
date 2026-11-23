export function examPhotoFilename(title,extension='webp'){
 const name=String(title??'').replace(/[<>:"/\\|?*\u0000-\u001f]/g,' ').replace(/\s+/g,' ').trim().slice(0,120);
 return `${name||'기출 문제'}.${extension}`;
}

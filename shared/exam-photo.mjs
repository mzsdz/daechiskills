export function examPhotoFilename(title){
 const name=String(title??'').replace(/[<>:"/\\|?*\u0000-\u001f]/g,' ').replace(/\s+/g,' ').trim().slice(0,120);
 return `${name||'기출 문제'}.png`;
}

export function examPhotoButton(title){
 const filename=examPhotoFilename(title).replace(/[&<>"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]));
 return `<button type="button" class="btn tiny exam-photo-download" data-exam-photo="${filename}">문제 사진 다운로드</button><span class="exam-photo-status" role="status"></span>`;
}

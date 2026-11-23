const filters=document.querySelector('#exam-download-filters');
const selects=[...filters.querySelectorAll('select')];
const papers=[...document.querySelectorAll('#exam-download-list li')];
const status=document.querySelector('#exam-download-count');

function showMatchingPapers(){
 const selected=selects.filter(select=>select.value);
 let count=0;
 for(const paper of papers){
  paper.hidden=!selected.every(select=>paper.dataset[select.name]===select.value);
  if(!paper.hidden)count++;
 }
 status.textContent=count?`문제지 ${count}개`:'선택한 조건의 문제지가 없어요.';
}

filters.addEventListener('change',showMatchingPapers);
filters.hidden=false;
showMatchingPapers();

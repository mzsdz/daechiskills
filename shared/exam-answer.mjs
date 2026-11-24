import keys from './exam-answer-keys.json' with {type:'json'};

export function examAnswer(details){
 const c=details?.classification;
 if(!c||!['standard','odd','even'].includes(c.variant))return null;
 const provider=c.provider==='education'||details.asset_path?.startsWith('/exam-images/education/')?'education':'kice';
 const grade=provider==='kice'?3:String(c.grade??'').replace(/^고/,'');
 const record=keys[`${provider}-${c.calendar_year}-${c.month}-${grade}`];
 const number=Number(c.question_no);
 const section=c.section;
 const index=number-(['common','math'].includes(section)?1:23);
 const value=record?.forms[c.variant]?.[section]?.[index];
 return value?{value,source:record.source}:null;
}

export function examAnswerMarkup(answer){
 if(!answer)return '';
 const source=answer.source.replaceAll('&','&amp;').replaceAll('"','&quot;');
 return `<p class="exam-answer"><strong>정답 ${answer.value}</strong> <a href="${source}" target="_blank" rel="noopener noreferrer">출처</a></p>`;
}

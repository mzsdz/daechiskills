// Capture the first downward movement before Safari starts native rubber-banding.
export function installPullToRefresh({refresh,reloadOnRefresh=false,canStart=()=>true,view=window,doc=document}){
 const indicator=doc.createElement('div');indicator.className='pull-refresh-status';indicator.setAttribute('role','status');indicator.setAttribute('aria-live','polite');indicator.hidden=true;
 indicator.innerHTML=`<svg class="pull-refresh-wheel" viewBox="0 0 48 48" aria-hidden="true">${Array.from({length:12},(_,i)=>`<line x1="24" y1="4" x2="24" y2="12" transform="rotate(${i*30} 24 24)" opacity="${(.2+i*.8/11).toFixed(2)}"/>`).join('')}</svg><span class="pull-refresh-label"></span>`;doc.body.append(indicator);
 const label=indicator.querySelector('.pull-refresh-label'),root=doc.documentElement;
 doc.documentElement.classList.add('pull-refresh-enabled');
 let gesture=null,running=false,disposed=false,timer,suppressedClick=null;
 const readyDistance=52;
 const atTop=()=>Math.max(view.scrollY||0,doc.scrollingElement?.scrollTop||0)<=2;
 const eligible=target=>{
  if(!atTop()||running||!canStart()||doc.querySelector('#modal-root,[aria-modal="true"]'))return false;
  if(target?.closest?.('input,textarea,select,canvas,[contenteditable="true"],[data-no-pull-refresh]'))return false;
  for(let el=target;el&&el!==doc.body&&el!==doc.documentElement;el=el.parentElement){
   if(el.scrollHeight>el.clientHeight+1&&/auto|scroll/.test(view.getComputedStyle(el).overflowY))return false;
  }
  return !view.visualViewport||Math.abs(view.visualViewport.scale-1)<.01;
 };
 const space=distance=>{root.style.setProperty('--pull-space',distance+'px');root.style.setProperty('--pull-angle',distance*4+'deg');root.style.setProperty('--pull-opacity',Math.min(1,distance/40));};
 const hide=()=>{root.classList.remove('pull-refresh-dragging');space(0);indicator.hidden=true;indicator.removeAttribute('data-phase');};
 const message=(phase,text)=>{indicator.hidden=false;if(indicator.dataset.phase!==phase){indicator.dataset.phase=phase;label.textContent=text;}};
 const cancel=()=>{gesture=null;if(!running)hide();};
 const start=e=>{
  suppressedClick=null;
  if(e.touches.length!==1){cancel();return;}
  if(!eligible(e.target)){cancel();return;}
  const header=doc.querySelector('#app > .topbar, #app > .editorial-header, .pull-refresh-document body > header');
  root.style.setProperty('--pull-top',Math.max(0,header?.getBoundingClientRect().bottom||0)+'px');
  view.clearTimeout(timer);const t=e.touches[0];gesture={id:t.identifier,x:t.clientX,y:t.clientY,distance:0,target:e.target,control:Boolean(e.target?.closest?.('button,summary'))};
 };
 const move=e=>{
  if(!gesture)return;
  if(e.touches.length!==1||!eligible(e.target)){cancel();return;}
  const t=e.touches[0];if(t.identifier!==gesture.id){cancel();return;}
  const dx=t.clientX-gesture.x,dy=t.clientY-gesture.y;
  if(dy<0||Math.abs(dx)>Math.max(12,Math.abs(dy))){cancel();return;}
  if(Math.abs(dx)>Math.abs(dy)&&Math.abs(dx)>2)return;
  if(gesture.control&&dy<=6)return;
  if(dy<=0){gesture.distance=0;hide();return;}
  if(!e.cancelable){cancel();return;}
  e.preventDefault();
  gesture.distance=Math.min(180,dy*.65);
  if(dy<10){hide();return;}
  suppressedClick={target:gesture.target,until:Date.now()+600};
  root.classList.add('pull-refresh-dragging');space(gesture.distance);
  message(gesture.distance>=readyDistance?'ready':'pull',gesture.distance>=readyDistance?'↻ 놓으면 새로고침':'↓ 아래로 당겨 새로고침');
 };
 const end=async()=>{
  const ready=gesture?.distance>=readyDistance&&atTop()&&canStart()&&!doc.querySelector('#modal-root,[aria-modal="true"]');gesture=null;
  if(!ready||running){if(!running)hide();return;}
  const reload=typeof reloadOnRefresh==='function'?reloadOnRefresh():reloadOnRefresh;
  running=true;root.classList.remove('pull-refresh-dragging');space(84);message('loading',reload?'↻ 페이지 새로고침 중…':'↻ 새로고침 중…');
  let navigating=false;
  try{await refresh();navigating=reload;if(!disposed&&!navigating)message('done','✓ 새로고침 완료');}
  catch{if(!disposed)message('error','연결을 확인하고 다시 당겨 주세요.');}
  finally{if(!navigating){running=false;if(!disposed)timer=view.setTimeout(hide,1400);}}
 };
 const click=e=>{if(!suppressedClick)return;const blocked=suppressedClick; suppressedClick=null;if(Date.now()<=blocked.until&&(blocked.target===e.target||blocked.target?.contains?.(e.target)||e.target?.contains?.(blocked.target))){e.preventDefault();e.stopImmediatePropagation();}};
 doc.addEventListener('click',click,true);
 doc.addEventListener('touchstart',start,{passive:true});doc.addEventListener('touchmove',move,{passive:false});doc.addEventListener('touchend',end,{passive:true});doc.addEventListener('touchcancel',cancel,{passive:true});view.addEventListener('hashchange',cancel);
 return ()=>{disposed=true;view.clearTimeout(timer);doc.removeEventListener('click',click,true);doc.removeEventListener('touchstart',start);doc.removeEventListener('touchmove',move);doc.removeEventListener('touchend',end);doc.removeEventListener('touchcancel',cancel);view.removeEventListener('hashchange',cancel);root.classList.remove('pull-refresh-enabled','pull-refresh-dragging');for(const name of ['--pull-space','--pull-angle','--pull-opacity','--pull-top'])root.style.removeProperty(name);indicator.remove();};
}

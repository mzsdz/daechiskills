/* Safari preserves pinch scale on reload. A fresh document navigation resets
   that history zoom; remove our one-use marker before the app reads the URL. */
(()=>{
 try{
  const marker='_ds_view_reset',url=new URL(location.href);
  if(url.searchParams.has(marker)){
   url.searchParams.delete(marker);
   history.replaceState(history.state,'',url.href);
   return;
  }
  const ios=/iPhone|iPad|iPod/.test(navigator.userAgent)||(/Mac/.test(navigator.platform)&&navigator.maxTouchPoints>1);
  const navigation=performance.getEntriesByType?.('navigation')?.[0];
  const reloaded=navigation?navigation.type==='reload':performance.navigation?.type===1;
  if(!ios||!reloaded)return;
  url.searchParams.set(marker,Date.now().toString(36));
  location.replace(url.href);
 }catch{/* URL/history restrictions must never prevent the application loading. */}
})();

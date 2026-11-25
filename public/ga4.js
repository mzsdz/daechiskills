(() => {
  if (!['daechiskills.com', 'www.daechiskills.com', 'daechiskills.vercel.app'].includes(location.hostname)) return;
  const id = 'G-83QC2SJV7V';
  window.dataLayer = window.dataLayer || [];
  function gtag() { window.dataLayer.push(arguments); }
  gtag('js', new Date());
  gtag('config', id);
  const script = document.createElement('script');
  script.async = true;
  script.src = `https://www.googletagmanager.com/gtag/js?id=${id}`;
  document.head.append(script);
})();

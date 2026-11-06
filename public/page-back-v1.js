(() => {
  const button = document.querySelector('.page-back');
  if (!button) return;
  button.addEventListener('click', event => {
    if (event.button !== 0 || event.metaKey || event.ctrlKey || event.shiftKey || event.altKey) return;
    let internalReferrer = false;
    try { internalReferrer = new URL(document.referrer).origin === location.origin; } catch {}
    if (internalReferrer && history.length > 1) {
      event.preventDefault();
      history.back();
    }
  });
})();

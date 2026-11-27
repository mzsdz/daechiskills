const filterNav = document.querySelector('.area-guide-filters');
const filterLinks = [...filterNav.querySelectorAll('[data-area-filter]')];
const thumbs = [...document.querySelectorAll('.area-thumb')];
const cards = [...document.querySelectorAll('.area-guide .area-card')];

function applyFilters() {
  const url = new URL(location.href);
  const degree = url.searchParams.get('degree') || '';
  const shape = url.searchParams.get('shape') || '';
  const visible = (item) => (!degree || item.dataset.degree === degree) && (!shape || item.dataset.shape === shape);
  for (const item of [...thumbs, ...cards]) item.hidden = !visible(item);
  const count = thumbs.filter(visible).length;
  document.querySelector('.area-result').textContent = `${count}가지 모양`;
  document.querySelector('.area-empty').hidden = count > 0;
  document.querySelector('.area-guide-contents').hidden = count === 0;
  if (shape) filterNav.querySelector('details').open = true;

  for (const link of filterLinks) {
    const { areaFilter, value } = link.dataset;
    const selected = (url.searchParams.get(areaFilter) || '') === value;
    if (selected) link.setAttribute('aria-current', 'true');
    else link.removeAttribute('aria-current');
    const next = new URL(url);
    next.hash = '';
    if (value) next.searchParams.set(areaFilter, value);
    else next.searchParams.delete(areaFilter);
    link.href = next.pathname + next.search;
  }
}

filterNav.addEventListener('click', (event) => {
  const link = event.target.closest('[data-area-filter]');
  if (!link || event.button !== 0 || event.ctrlKey || event.metaKey || event.shiftKey || event.altKey) return;
  event.preventDefault();
  if (link.href !== location.href) history.pushState(null, '', link.href);
  applyFilters();
});
addEventListener('popstate', applyFilters);
applyFilters();

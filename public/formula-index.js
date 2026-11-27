const search = document.querySelector('.formula-search');
const input = search.querySelector('input');
const clear = search.querySelector('.formula-search-clear');
const status = document.querySelector('.formula-search-status');

const normalize = (value) => value.normalize('NFKC').toLowerCase().replace(/⁄/g, '/').replace(/\s+/g, '');
const units = Array.from(document.querySelectorAll('.formula-unit'), (unit) => {
  const title = unit.querySelector('h2').textContent;
  const entries = Array.from(unit.querySelectorAll('.formula-entry'), (entry) => ({
    entry,
    terms: [title, entry.querySelector('summary').textContent, ...entry.dataset.keywords.split(',')].map(normalize),
  }));
  return { unit, entries, count: unit.querySelector('.formula-unit-count') };
});

function filter() {
  const query = normalize(input.value);
  let total = 0;
  for (const { unit, entries, count } of units) {
    let visible = 0;
    for (const { entry, terms } of entries) {
      entry.hidden = !terms.some((term) => term.includes(query));
      if (!entry.hidden) visible += 1;
    }
    count.textContent = `${visible}개`;
    unit.hidden = visible === 0;
    total += visible;
  }
  clear.hidden = input.value.length === 0;
  status.toggleAttribute('data-has-results', total > 0);
  status.textContent = total ? `공식 ${total}개` : '검색 결과가 없어요. 다른 키워드를 입력해 보세요.';
}

input.addEventListener('input', filter);
clear.addEventListener('click', () => {
  input.value = '';
  filter();
  input.focus();
});
for (const example of search.querySelectorAll('.formula-search-examples button')) {
  example.addEventListener('click', () => {
    input.value = example.textContent;
    filter();
  });
}
search.hidden = false;

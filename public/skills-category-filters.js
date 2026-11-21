document.addEventListener('click', event => {
  const button = event.target.closest('button[data-final-filter]');
  if (!button) return;

  const collection = button.closest('[data-finals-collection]');
  const row = key => collection.querySelector('[data-final-row="' + key + '"]');
  const selected = key => row(key).querySelector('[aria-pressed="true"]').value;
  const select = option => {
    for (const item of option.parentElement.querySelectorAll('button')) {
      item.setAttribute('aria-pressed', String(item === option));
    }
  };

  select(button);
  const cards = [...collection.querySelectorAll('[data-final-book]')];
  const book = selected('book');
  const bookCards = cards.filter(card => !book || card.dataset.finalBook === book);
  if (button.dataset.finalFilter !== 'unit') {
    const unitRow = row('unit');
    const previous = selected('unit');
    const unitCounts = new Map();
    for (const card of book ? bookCards : []) {
      const unit = card.dataset.finalUnit;
      unitCounts.set(unit, (unitCounts.get(unit) || 0) + 1);
    }
    const current = unitCounts.has(previous) ? previous : '';
    unitRow.querySelectorAll('button').forEach(item => item.remove());
    for (const [value, count] of [['', bookCards.length], ...unitCounts]) {
      const item = document.createElement('button');
      item.type = 'button';
      item.dataset.finalFilter = 'unit';
      item.value = value;
      const badge = document.createElement('span');
      badge.className = 'finals-filter-count';
      badge.textContent = count;
      item.append((value || '전체') + ' ', badge);
      item.setAttribute('aria-pressed', String(value === current));
      unitRow.append(item);
    }
    unitRow.hidden = !book;
  }

  const unit = selected('unit');
  const visible = new Set(bookCards.filter(card => !unit || card.dataset.finalUnit === unit));
  for (const card of cards) card.hidden = !visible.has(card);
  collection.querySelector('[data-finals-status]').textContent = visible.size
    ? '글 ' + visible.size + '편'
    : '이 조건에 맞는 글은 아직 없어요.';
});

document.addEventListener('click', async event => {
  const button = event.target.closest('[data-skill-share]');
  if (!button || button.disabled) return;
  const url = new URL(button.dataset.skillShare, location.origin).href;
  button.disabled = true;
  try {
    if (navigator.share) {
      try {
        await navigator.share({url});
        void recordSkillShare(button.dataset.skillShare);
        return;
      } catch (error) {
        if (error.name === 'AbortError') return;
      }
    }
    try {
      await navigator.clipboard.writeText(url);
      void recordSkillShare(button.dataset.skillShare);
      const label = button.querySelector('[data-share-label]') || button;
      label.textContent = '복사됨';
      setTimeout(() => { label.textContent = '공유'; }, 1600);
    } catch {
      window.prompt('스킬 주소 복사', url);
    }
  } finally {
    button.disabled = false;
  }
});

const skillCounts = new Map();
let skillCountsRequested = false;
let skillCountGeneration = 0;
const skillCountFormatter = new Intl.NumberFormat('ko-KR');

function paintSkillCounts() {
  for (const badge of document.querySelectorAll('[data-skill-count]')) {
    const total = skillCounts.get(badge.dataset.countRoute)?.[badge.dataset.skillCount];
    const label = Number.isSafeInteger(total) ? skillCountFormatter.format(total) : '–';
    if (badge.textContent !== label) badge.textContent = label;
  }
}

async function refreshSkillCounts() {
  if (!document.querySelector('[data-skill-count]')) return;
  const generation = ++skillCountGeneration;
  skillCountsRequested = true;
  try {
    const response = await fetch('/api/skill-counts');
    if (!response.ok) throw new Error('Counts unavailable');
    const rows = await response.json();
    if (generation !== skillCountGeneration) return;
    for (const row of rows) skillCounts.set(row.route,row);
    paintSkillCounts();
  } catch {
    if (generation === skillCountGeneration) skillCountsRequested = false;
  }
}

async function recordSkillShare(path) {
  const route = path.slice(1).replace(/^optimized-solutions\//,'optimized/');
  try {
    const response = await fetch('/api/skill-counts',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({route})});
    if (response.ok) await refreshSkillCounts();
  } catch {}
}

const countObserver = new MutationObserver(records => {
  const hasActions = records.some(record => [...record.addedNodes].some(node =>
    node.nodeType === 1 && (node.matches('[data-skill-count]') || node.querySelector('[data-skill-count]'))
  ));
  if (!hasActions) return;
  paintSkillCounts();
  if (!skillCountsRequested) void refreshSkillCounts();
});
countObserver.observe(document.body,{childList:true,subtree:true});
document.addEventListener('skill-counts-refresh',refreshSkillCounts);
void refreshSkillCounts();

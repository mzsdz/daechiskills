export const difficultyLevels=[['unclassified','미분류'],['semi','준준킬러'],['advanced','준킬러'],['killer','킬러']];
export const difficultyLabel=level=>difficultyLevels.find(([key])=>key===level)?.[1]||'미분류';
export function difficultyTag(p){const level=difficultyLevels.some(([key])=>key===p.difficulty)?p.difficulty:'unclassified';return `<span class="difficulty-tag difficulty-${level}" aria-label="난이도 ${difficultyLabel(level)}">${difficultyLabel(level)}</span>`;}

export const normalizeDifficulty=level=>difficultyLevels.some(([key])=>key===level)?level:'unclassified';

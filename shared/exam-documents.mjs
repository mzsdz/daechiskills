import {historicalExamDocuments} from './historical-exam-documents.mjs';
import {legacyArchiveUrls,legacyExamDocuments} from './legacy-exam-documents.mjs';

// In the archive, KICE assigns a fileSeq. For the exam-day PDFs, use the
// first 128 bits of the verified file's SHA-256 as the internal document ID.
export const examDayDocuments = new Map([
  ['b5787b27c7bd5232a5e263ed3564303d', 'https://wdown.ebsi.co.kr/W61001/01exam/20261119/go3/live_main_paper_1_math_K63RYJL3.pdf'],
  ['fcc79b1fe0eb155d86f9e38785ea3ad2', 'https://wdown.ebsi.co.kr/W61001/01exam/20261119/go3/live_main_paper_2_math_F51864J3.pdf'],
]);

export const hostedExamDocuments = new Map([...examDayDocuments, ...historicalExamDocuments, ...legacyExamDocuments]);
const hostedExamIds = new Map([...hostedExamDocuments].map(([id,url])=>[url,id]));
export const isLegacyArchive = url => legacyArchiveUrls.has(url);

export function examDocumentId(url) {
  if (typeof url !== 'string') return null;
  const archived = /^https:\/\/www\.suneung\.re\.kr\/boardCnts\/fileDown\.do\?fileSeq=([a-f0-9]{32})$/.exec(url);
  if (archived) return archived[1];
  return hostedExamIds.get(url)??null;
}

export const combinedCsatPapers = new Map([
  ['4dee411efbfef1ab1b44fde9dc8f9378', {year:2022, oddPages:20}],
  ['23bed50b6f952ec50a0e40f376fdb358', {year:2023, oddPages:20}],
]);

export const latestCsatOddPaper = examDayDocuments.get('b5787b27c7bd5232a5e263ed3564303d');

export function csatOddPaperUrl(url,page=1) {
  const id=examDocumentId(url);
  if(id==='f9055b3484e9176cea7c74b9819a7d2c'&&page<=20)
    return 'https://wdown.ebsi.co.kr/W61001/01exam/20251113/go3/live_main_paper_1_math_9Q5HR738.pdf';
  const combined=combinedCsatPapers.get(id);
  if(combined&&page<=combined.oddPages)return `/api/exam-document?file=${id}&form=odd`;
  return url;
}

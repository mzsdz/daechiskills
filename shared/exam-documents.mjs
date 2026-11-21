// In the archive, KICE assigns a fileSeq. For the exam-day PDFs, use the
// first 128 bits of the verified file's SHA-256 as the internal document ID.
export const examDayDocuments = new Map([
  ['b5787b27c7bd5232a5e263ed3564303d', 'https://wdown.ebsi.co.kr/W61001/01exam/20261119/go3/live_main_paper_1_math_K63RYJL3.pdf'],
  ['fcc79b1fe0eb155d86f9e38785ea3ad2', 'https://wdown.ebsi.co.kr/W61001/01exam/20261119/go3/live_main_paper_2_math_F51864J3.pdf'],
]);

export function examDocumentId(url) {
  if (typeof url !== 'string') return null;
  const archived = /^https:\/\/www\.suneung\.re\.kr\/boardCnts\/fileDown\.do\?fileSeq=([a-f0-9]{32})$/.exec(url);
  if (archived) return archived[1];
  for (const [id, documentUrl] of examDayDocuments) {
    if (url === documentUrl) return id;
  }
  return null;
}

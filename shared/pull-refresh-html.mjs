export function withDocumentPullRefresh(html) {
 const css=html.includes('href="/pull-refresh.css"')?'':'<link rel="stylesheet" href="/pull-refresh.css">';
 const script=html.includes('src="/document-pull-refresh.js"')?'':'<script type="module" src="/document-pull-refresh.js"></script>';
 return html.replace('</head>',css+script+'</head>');
}

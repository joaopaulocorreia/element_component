import { execSync } from "child_process";
import { readFileSync, mkdirSync } from "fs";
import { join, dirname } from "path";
import { fileURLToPath } from "url";
import hljs from "highlight.js";

const __dirname = dirname(fileURLToPath(import.meta.url));
const root = join(__dirname, "..");
const imagesDir = join(root, "images");
const highlightCss = readFileSync(
  join(root, "node_modules", "highlight.js", "styles", "atom-one-dark.css"),
  "utf-8"
);

mkdirSync(imagesDir, { recursive: true });

const examples = [
  "alert_example.rb",
  "badge_example.rb",
  "breadcrumb_example.rb",
  "button_example.rb",
  "button_group_example.rb",
  "card_example.rb",
  "close_button_example.rb",
  "list_group_example.rb",
  "nav_example.rb",
  "pagination_example.rb",
  "progress_example.rb",
  "spinner_example.rb",
  "table_example.rb",
  "modal_example.rb",
  "carousel_example.rb",
  "dropdown_example.rb",
  "navbar_example.rb",
];

/* Highlight Ruby code server-side */
function highlightRuby(code) {
  const result = hljs.highlight(code, { language: "ruby" });
  return result.value;
}

/* Parse Ruby source into code sections by ===== markers */
function parseSourceCode(source) {
  const lines = source.split("\n");
  const sections = [];
  let current = null;

  for (const line of lines) {
    if (line.startsWith("# ===")) {
      if (current) sections.push(current);
      const title = line.replace(/# =+/g, "").trim();
      current = { title, code: [] };
      continue;
    }
    if (current) {
      current.code.push(line);
    }
  }
  if (current) sections.push(current);
  return sections;
}

/* Match output sections with source sections */
function matchSections(sourceSections, outputSections) {
  return sourceSections.map((src, i) => {
    const out = outputSections[i] || { html: [] };
    const displayCode = src.code
      .filter((l) => !/^\s*puts\s/.test(l) && !/^\s*$/.test(l))
      .join("\n")
      .trim();
    return {
      title: out.title || src.title,
      code: displayCode,
      html: (out.html || []).join("\n"),
    };
  });
}

function runExample(name) {
  const path = join(root, "examples", name);
  const output = execSync(`ruby ${path}`, { encoding: "utf-8", cwd: root });

  // Parse output
  const outLines = output.trim().split("\n");
  const outputSections = [];
  let cur = null;
  for (const line of outLines) {
    const m = line.match(/^=== (.+) ===$/);
    if (m) {
      if (cur) outputSections.push(cur);
      cur = { title: m[1], html: [] };
    } else if (cur) {
      cur.html.push(line);
    }
  }
  if (cur) outputSections.push(cur);

  // Parse source
  const source = readFileSync(path, "utf-8");
  const sourceSections = parseSourceCode(source);
  const matched = matchSections(sourceSections, outputSections);

  return { name: name.replace("_example.rb", ""), sections: matched };
}

function buildPage(componentName, sections) {
  const rows = sections
    .map(
      (s, i) => `
    <div class="example-row">
      <div class="section-label">${escHtml(s.title)}</div>
      <div class="split-pane">
        <div class="code-pane">
          <pre><code>${highlightRuby(s.code) || escHtml(s.code)}</code></pre>
        </div>
        <div class="output-pane">
          ${s.html}
        </div>
      </div>
    </div>`
    )
    .join("\n");

  return `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif;
      background: #0d1117;
      padding: 32px;
    }
    .page {
      max-width: 1200px;
      margin: 0 auto;
    }
    .header {
      margin-bottom: 28px;
    }
    .header h1 {
      font-size: 26px;
      font-weight: 700;
      color: #f0f6fc;
    }
    .header p {
      font-size: 14px;
      color: #8b949e;
      margin-top: 4px;
    }
    .example-row {
      margin-bottom: 24px;
    }
    .section-label {
      font-size: 11px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.8px;
      color: #8b949e;
      margin-bottom: 8px;
      padding-left: 4px;
    }
    .split-pane {
      display: flex;
      border-radius: 10px;
      overflow: hidden;
      border: 1px solid #30363d;
    }
    .code-pane {
      flex: 1;
      background: #1c2128;
      padding: 16px;
      overflow-x: auto;
      min-width: 0;
    }
    .code-pane pre {
      margin: 0;
      font-family: 'JetBrains Mono', 'Fira Code', 'Cascadia Code', 'Consolas', monospace;
      font-size: 13px;
      line-height: 1.6;
    }
    .code-pane code {
      background: none !important;
      padding: 0 !important;
    }
    .output-pane {
      flex: 1;
      background: #ffffff;
      padding: 20px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      min-height: 60px;
      border-left: 1px solid #30363d;
    }
    /* highlight.js overrides */
    pre code.hljs { background: transparent !important; padding: 0 !important; }
    ${highlightCss}

    /* Bootstrap 5.3 CSS (minimal) */
    .alert { position:relative; padding:1rem 1rem; margin-bottom:1rem; border:1px solid transparent; border-radius:.375rem; }
    .alert-primary { color:#084298; background-color:#cfe2ff; border-color:#b6d4fe; }
    .alert-secondary { color:#41464b; background-color:#e2e3e5; border-color:#d3d6d8; }
    .alert-success { color:#0f5132; background-color:#d1e7dd; border-color:#badbcc; }
    .alert-danger { color:#842029; background-color:#f8d7da; border-color:#f5c2c7; }
    .alert-warning { color:#664d03; background-color:#fff3cd; border-color:#ffecb5; }
    .alert-info { color:#055160; background-color:#cff4fc; border-color:#b6effb; }
    .alert-light { color:#636464; background-color:#fefefe; border-color:#fdfdfe; }
    .alert-dark { color:#141619; background-color:#d3d3d4; border-color:#bcbebf; }
    .alert-dismissible { padding-right:3rem; }
    .alert-heading { color:inherit; }
    .alert-link { font-weight:700; }
    .btn-close { box-sizing:content-box; width:1em; height:1em; padding:.25em; color:#000; background:transparent url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' fill='%23000'%3e%3cpath d='M.293.293a1 1 0 0 1 1.414 0L8 6.586 14.293.293a1 1 0 1 1 1.414 1.414L9.414 8l6.293 6.293a1 1 0 0 1-1.414 1.414L8 9.414l-6.293 6.293a1 1 0 0 1-1.414-1.414L6.586 8 .293 1.707a1 1 0 0 1 0-1.414z'/%3e%3c/svg%3e") center/1em auto no-repeat; border:0; border-radius:.375rem; opacity:.5; float:right; cursor:pointer; }
    .badge { display:inline-block; padding:.35em .65em; font-size:.75em; font-weight:700; line-height:1; color:#fff; text-align:center; white-space:nowrap; vertical-align:baseline; border-radius:.375rem; }
    .bg-primary { background-color:#0d6efd; } .bg-secondary { background-color:#6c757d; } .bg-success { background-color:#198754; }
    .bg-danger { background-color:#dc3545; } .bg-warning { background-color:#ffc107; } .bg-info { background-color:#0dcaf0; }
    .bg-light { background-color:#f8f9fa; color:#000; } .bg-dark { background-color:#212529; }
    .rounded-pill { border-radius:50rem; }
    .card { position:relative; display:flex; flex-direction:column; min-width:0; word-wrap:break-word; background-color:#fff; background-clip:border-box; border:1px solid rgba(0,0,0,.125); border-radius:.375rem; }
    .card-header { padding:1rem 1rem; margin-bottom:0; background-color:rgba(0,0,0,.03); border-bottom:1px solid rgba(0,0,0,.125); }
    .card-body { flex:1 1 auto; padding:1rem 1rem; }
    .card-footer { padding:1rem 1rem; background-color:rgba(0,0,0,.03); border-top:1px solid rgba(0,0,0,.125); }
    .card-title { margin-bottom:.5rem; font-size:1.25rem; font-weight:500; }
    .card-text { margin-top:0; margin-bottom:1rem; }
    .card-img-top { width:100%; border-top-left-radius:calc(.375rem - 1px); border-top-right-radius:calc(.375rem - 1px); display:block; }
    .nav { display:flex; flex-wrap:wrap; padding-left:0; margin-bottom:0; list-style:none; }
    .nav-tabs { border-bottom:1px solid #dee2e6; }
    .nav-tabs .nav-link { margin-bottom:-1px; background:0 0; border:1px solid transparent; border-top-left-radius:.375rem; border-top-right-radius:.375rem; }
    .nav-tabs .nav-link.active { color:#495057; background-color:#fff; border-color:#dee2e6 #dee2e6 #fff; }
    .nav-pills .nav-link.active { color:#fff; background-color:#0d6efd; }
    .nav-link { display:block; padding:.5rem 1rem; font-size:1rem; color:#0d6efd; text-decoration:none; background:0 0; }
    .nav-link.disabled { color:#6c757d; pointer-events:none; cursor:default; }
    .breadcrumb { display:flex; flex-wrap:wrap; padding:0; margin-bottom:1rem; list-style:none; }
    .breadcrumb-item + .breadcrumb-item { padding-left:.5rem; }
    .breadcrumb-item + .breadcrumb-item::before { float:left; padding-right:.5rem; color:#6c757d; content:"/"; }
    .breadcrumb-item.active { color:#6c757d; }
    .list-group { display:flex; flex-direction:column; padding-left:0; margin-bottom:0; border-radius:.375rem; }
    .list-group-item { position:relative; display:block; padding:.5rem 1rem; color:#212529; text-decoration:none; background-color:#fff; border:1px solid rgba(0,0,0,.125); }
    .list-group-item.active { z-index:2; color:#fff; background-color:#0d6efd; border-color:#0d6efd; }
    .list-group-item-action { color:#495057; }
    .list-group-item-action:hover { z-index:1; color:#495057; background-color:#f8f9fa; }
    .list-group-flush { border-radius:0; }
    .list-group-flush .list-group-item { border-right:0; border-left:0; border-radius:0; }
    .list-group-flush .list-group-item:first-child { border-top:0; }
    .list-group-flush .list-group-item:last-child { border-bottom:0; }
    .pagination { display:flex; padding-left:0; list-style:none; }
    .page-item.active .page-link { z-index:3; color:#fff; background-color:#0d6efd; border-color:#0d6efd; }
    .page-link { position:relative; display:block; padding:.375rem .75rem; font-size:1rem; color:#0d6efd; text-decoration:none; background-color:#fff; border:1px solid #dee2e6; }
    .page-item:first-child .page-link { border-top-left-radius:.375rem; border-bottom-left-radius:.375rem; }
    .page-item:last-child .page-link { border-top-right-radius:.375rem; border-bottom-right-radius:.375rem; }
    .progress { display:flex; height:1rem; overflow:hidden; font-size:.75rem; background-color:#e9ecef; border-radius:.375rem; }
    .progress-bar { display:flex; flex-direction:column; justify-content:center; overflow:hidden; color:#fff; text-align:center; white-space:nowrap; background-color:#0d6efd; }
    .progress-bar-striped { background-image:linear-gradient(45deg,rgba(255,255,255,.15) 25%,transparent 25%,transparent 50%,rgba(255,255,255,.15) 50%,rgba(255,255,255,.15) 75%,transparent 75%,transparent); background-size:1rem 1rem; }
    .spinner-border { display:inline-block; width:2rem; height:2rem; vertical-align:-.125em; border:.25em solid currentcolor; border-right-color:transparent; border-radius:50%; animation:spinner-border .75s linear infinite; }
    .spinner-grow { display:inline-block; width:2rem; height:2rem; vertical-align:-.125em; background-color:currentcolor; border-radius:50%; opacity:0; animation:spinner-grow .75s linear infinite; }
    @keyframes spinner-border { to { transform:rotate(360deg); } }
    @keyframes spinner-grow { 0% { transform:scale(0); } 50% { opacity:1; transform:none; } }
    .text-primary { color:#0d6efd; } .text-secondary { color:#6c757d; } .text-success { color:#198754; }
    .text-danger { color:#dc3545; } .text-warning { color:#ffc107; } .text-info { color:#0dcaf0; }
    .text-light { color:#f8f9fa; } .text-dark { color:#212529; }
    .table { width:100%; margin-bottom:1rem; color:#212529; border-color:#dee2e6; border-collapse:collapse; }
    .table-striped tbody tr:nth-of-type(odd) { background-color:rgba(0,0,0,.05); }
    .table-bordered th, .table-bordered td { border:1px solid #dee2e6; }
    .table-hover tbody tr:hover { background-color:rgba(0,0,0,.075); }
    .table-sm th, .table-sm td { padding:.25rem; }
    .btn { display:inline-block; padding:.375rem .75rem; font-size:1rem; font-weight:400; line-height:1.5; text-align:center; text-decoration:none; vertical-align:middle; cursor:default; border:1px solid transparent; border-radius:.375rem; white-space:nowrap; }
    .btn-primary { color:#fff; background-color:#0d6efd; border-color:#0d6efd; }
    .btn-outline-danger { color:#dc3545; border-color:#dc3545; background:0 0; }
    .btn-success { color:#fff; background-color:#198754; border-color:#198754; }
    .btn-secondary { color:#fff; background-color:#6c757d; border-color:#6c757d; }
    .btn-group { position:relative; display:inline-flex; vertical-align:middle; }
    .btn-group > .btn { position:relative; flex:1 1 auto; }
    .btn-group > .btn:not(:last-child) { border-top-right-radius:0; border-bottom-right-radius:0; }
    .btn-group > .btn:nth-child(n+3) { border-top-left-radius:0; border-bottom-left-radius:0; }
    .btn-group > .btn:not(:first-child) { margin-left:-1px; }
    .btn-group-vertical { position:relative; display:inline-flex; flex-direction:column; vertical-align:middle; }
    .btn-group-vertical > .btn:not(:last-child) { border-bottom-right-radius:0; border-bottom-left-radius:0; }
    .btn-group-vertical > .btn:not(:first-child) { border-top-left-radius:0; border-top-right-radius:0; margin-top:-1px; }
    .btn-lg { padding:.5rem 1rem; font-size:1.25rem; border-radius:.5rem; }
    h4 { font-size:1.5rem; font-weight:500; line-height:1.2; margin-bottom:.5rem; }
    h5 { font-size:1.25rem; font-weight:500; line-height:1.2; margin-bottom:.5rem; }
    a { color:#0d6efd; text-decoration:underline; }
    p { margin-top:0; margin-bottom:1rem; }
    th, td { border-bottom:1px solid #dee2e6; padding:.5rem; text-align:left; }
    .visually-hidden { position:absolute; width:1px; height:1px; padding:0; margin:-1px; overflow:hidden; clip:rect(0,0,0,0); white-space:nowrap; border:0; }
  </style>
</head>
<body>
  <div class="page">
    <div class="header">
      <h1>🟦 ${capitalize(componentName)}</h1>
      <p>ElementComponent::Components::${capitalize(componentName)} — Ruby code + Bootstrap 5 output</p>
    </div>
    ${rows}
  </div>
</body>
</html>`;
}

function capitalize(s) {
  return s.charAt(0).toUpperCase() + s.slice(1);
}

function escHtml(s) {
  return s
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}

async function run() {
  const results = [];

  for (const ex of examples) {
    console.log(`  Running ${ex}...`);
    try {
      const result = runExample(ex);
      results.push(result);
    } catch (e) {
      console.warn(`  Warning: ${ex} failed: ${e.message}`);
    }
  }

  const { default: puppeteer } = await import("puppeteer");
  const browser = await puppeteer.launch({
    headless: true,
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
  });

  const page = await browser.newPage();
  await page.setViewport({ width: 1400, height: 800 });

  for (const result of results) {
    const name = result.name;
    console.log(`  Screenshotting ${name}...`);

    const html = buildPage(name, result.sections);
    await page.setContent(html, { waitUntil: "domcontentloaded" });

    const bodyHeight = await page.evaluate(() =>
      Math.max(document.body.scrollHeight, 200)
    );
    await page.setViewport({ width: 1400, height: bodyHeight + 40 });

    const path = join(imagesDir, `${name}.png`);
    await page.screenshot({ path, fullPage: false });
    console.log(`    -> ${path}`);
  }

  await browser.close();
  console.log("\nDone! All screenshots saved to images/");
}

run().catch((err) => {
  console.error("Error:", err);
  process.exit(1);
});

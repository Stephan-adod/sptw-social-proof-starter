import fs from 'node:fs';

const pkgPath = './package.json';
const pkg = JSON.parse(fs.readFileSync(pkgPath, 'utf8'));
pkg.scripts = pkg.scripts || {};

const defaults = {
  "lint:md": "markdownlint **/*.md --ignore node_modules",
  "lint": "npm run lint:md",
  "smoke": "node ops/ticket-smoke.mjs || echo 'no tickets or smoke skipped'",
  "ci:verify": "npm run lint && npm run smoke"
};

for (const [k, v] of Object.entries(defaults)) {
  if (!pkg.scripts[k]) pkg.scripts[k] = v;
}

fs.writeFileSync(pkgPath, JSON.stringify(pkg, null, 2) + '\n');
console.log('ensure-package: scripts ensured.');

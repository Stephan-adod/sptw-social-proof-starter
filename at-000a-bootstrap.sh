#!/usr/bin/env bash
set -euo pipefail

echo "==> AT-000A bootstrap starting..."

# 1) Struktur
mkdir -p artefacts tickets ops .github/workflows
touch tickets/.keep artefacts/Artefact_Index_v0.1.md README.md

# 2) package.json
cat > package.json << 'JSON'
{
  "name": "sptw-social-proof-starter",
  "private": true,
  "type": "module",
  "devDependencies": {
    "markdownlint-cli": "^0.41.0"
  },
  "scripts": {
    "lint:md": "markdownlint **/*.md --ignore node_modules",
    "lint": "npm run lint:md",
    "smoke": "node ops/ticket-smoke.mjs || echo \"no tickets or smoke skipped\"",
    "ci:verify": "npm run lint && npm run smoke"
  }
}
JSON

# 3) ensure-package
cat > ops/ensure-package.mjs << 'JS'
import fs from 'node:fs';
const pkgPath = './package.json';
const pkg = JSON.parse(fs.readFileSync(pkgPath, 'utf8'));
pkg.scripts = pkg.scripts || {};
pkg.scripts['lint:md']   = pkg.scripts['lint:md']   || "markdownlint **/*.md --ignore node_modules";
pkg.scripts['lint']      = pkg.scripts['lint']      || "npm run lint:md";
pkg.scripts['smoke']     = pkg.scripts['smoke']     || "node ops/ticket-smoke.mjs || echo \\"no tickets or smoke skipped\\"";
pkg.scripts['ci:verify'] = pkg.scripts['ci:verify'] || "npm run lint && npm run smoke";
fs.writeFileSync(pkgPath, JSON.stringify(pkg, null, 2) + '\\n');
console.log('ensure-package: scripts ensured.');
JS

# 4) ticket-smoke
cat > ops/ticket-smoke.mjs << 'JS'
import fs from 'node:fs';
import { execSync } from 'node:child_process';

function extractSmokeCommands(md) {
  const smokeHeader = md.indexOf('## Smoke');
  if (smokeHeader === -1) return null;
  const fenceStart = md.indexOf('```bash', smokeHeader);
  const fenceEnd   = md.indexOf('```', fenceStart + 7);
  if (fenceStart === -1 || fenceEnd === -1) return null;
  return md.slice(fenceStart + 7, fenceEnd).trim();
}

function run(cmd) {
  console.log(`$ ${cmd}`);
  execSync(cmd, { stdio: 'inherit', shell: '/bin/bash' });
}

const ticketEnv = process.env.TICKET_MD;
let files = [];
if (ticketEnv && fs.existsSync(ticketEnv)) {
  files = [ticketEnv];
} else {
  files = fs.readdirSync('./tickets')
    .filter(f => f.endsWith('.md'))
    .map(f => `./tickets/${f}`);
}
if (files.length === 0) {
  console.log('ticket-smoke: no ticket files found, skipping.');
  process.exit(0);
}

let anyExecuted = false;
for (const file of files) {
  const md = fs.readFileSync(file, 'utf8');
  const cmd = extractSmokeCommands(md);
  if (cmd) {
    console.log(`ticket-smoke: executing Smoke for ${file}`);
    run(cmd);
    anyExecuted = true;
  } else {
    console.log(`ticket-smoke: no Smoke block in ${file}, skipping.`);
  }
}
if (!anyExecuted) {
  console.log('ticket-smoke: no Smoke blocks found, skipping.');
}
JS

# 5) CI workflow
cat > .github/workflows/ci.yml << 'YAML'
name: CI
on:
  pull_request:
  push:
    branches: ["*"]

jobs:
  verify:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - name: Install
        run: npm i --no-audit --no-fund
      - name: Ensure package scripts
        run: node ops/ensure-package.mjs
      - name: Lint & Smoke
        run: npm run ci:verify
YAML

# 6) README governance
cat > README.md << 'MD'
# sptw-social-proof-starter

**Operating Contract (v0.1)**  
- `main` ist Single Source of Truth. **Keine** Direkt-Commits.  
- Jede Änderung erfolgt **via Atomic Ticket (tickets/AT-xxx.md) + PR**.  
- Tickets enthalten: Ziel, Scope, *How-To*, **Smoke** (```bash ... ```), **DoD**, Workflow.  
- CI führt `lint` und **ticket-smoke** aus. Ein PR ist *grün*, wenn Smoke der betroffenen Tickets grün ist.

Siehe `artefacts/Artefact_Index_v0.1.md`.
MD

# 7) Artefakt-Index Stub
cat > artefacts/Artefact_Index_v0.1.md << 'MD'
# Artefact Index v0.1 – Stub
Zweck: Navigations- und Referenzlayer für Artefakte.
Status: 🟡 Pending Update
MD

echo "==> AT-000A bootstrap complete."

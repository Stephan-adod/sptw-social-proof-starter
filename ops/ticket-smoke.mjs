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

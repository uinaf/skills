#!/usr/bin/env -S node --experimental-strip-types
import { execFileSync } from 'node:child_process';
import { existsSync, readFileSync, writeFileSync } from 'node:fs';
import { createHash } from 'node:crypto';
import { homedir } from 'node:os';
import { join } from 'node:path';

type Skill = { name: string; source: string };
type Manifest = {
  skills: Skill[];
  version?: number;
  manifestHash?: string;
  updatedAt?: string;
};

const REPO_DIR =
  process.env.AGENTS_DIR ??
  execFileSync('git', ['rev-parse', '--show-toplevel'], { encoding: 'utf-8' }).trim();
process.chdir(REPO_DIR);

const GLOBAL_LOCK = join(homedir(), '.agents', '.skill-lock.json');
const MANIFEST_PATH = join(REPO_DIR, 'scripts/sync/skills.json');

if (existsSync(GLOBAL_LOCK)) {
  const lock = JSON.parse(readFileSync(GLOBAL_LOCK, 'utf-8')) as {
    skills?: Record<string, { source: string }>;
  };
  const skills: Skill[] = Object.entries(lock.skills ?? {})
    .map(([name, value]) => ({ name, source: value.source }))
    .sort((a, b) => a.name.localeCompare(b.name));

  // Match the legacy bash hash exactly: sha256(jq -c '.skills' + '\n').
  const newHash = createHash('sha256')
    .update(JSON.stringify(skills) + '\n')
    .digest('hex');

  const current: Manifest = existsSync(MANIFEST_PATH)
    ? (JSON.parse(readFileSync(MANIFEST_PATH, 'utf-8')) as Manifest)
    : { skills: [] };
  const currentVersion = current.version ?? 0;
  const currentHash = current.manifestHash ?? '';
  const nextVersion = newHash !== currentHash ? currentVersion + 1 : currentVersion;
  const updatedAt = new Date().toISOString().replace(/\.\d+Z$/, 'Z');

  const next: Manifest = {
    skills,
    version: nextVersion,
    manifestHash: newHash,
    updatedAt,
  };
  writeFileSync(MANIFEST_PATH, JSON.stringify(next, null, 2) + '\n');
  console.log(`Synced ${MANIFEST_PATH} (version=${nextVersion}, hash=${newHash})`);
}

const status = execFileSync('git', ['status', '--porcelain'], { encoding: 'utf-8' });
if (status.trim() === '') {
  console.log('Nothing to push.');
  process.exit(0);
}

execFileSync('git', ['add', '-A'], { stdio: 'inherit' });
execFileSync('git', ['diff', '--cached', '--stat'], { stdio: 'inherit' });

const manifest: Manifest = existsSync(MANIFEST_PATH)
  ? (JSON.parse(readFileSync(MANIFEST_PATH, 'utf-8')) as Manifest)
  : { skills: [] };
const autoVersion = manifest.version ?? 0;
const autoHash = (manifest.manifestHash ?? '').slice(0, 8);
const autoMsg = `chore(skills): sync manifest v${autoVersion} (${autoHash})`;
const msg = process.env.COMMIT_MSG ?? autoMsg;

console.log(`Auto-commit: ${msg}`);
execFileSync('git', ['commit', '-m', msg], { stdio: 'inherit' });
execFileSync('git', ['push'], { stdio: 'inherit' });
console.log('Pushed.');

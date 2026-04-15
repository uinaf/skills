# Hardening a TypeScript CLI Tool for Agent Collaboration

## Problem/Feature Description

A small team is using a TypeScript CLI tool that converts CSV files to JSON. Two agents are already working on the codebase, but they keep accidentally pushing broken builds to the main branch — the unit tests pass locally because they're all mocked, but the actual CLI behavior breaks frequently. The team lead wants to add a proper enforcement layer so that broken code physically cannot be pushed, and wants real end-to-end tests that prove the CLI works correctly on actual files.

You've been asked to set up the mechanical enforcement layer and add an honest end-to-end test for the CLI. The team also wants to identify any dead code in the project. Produce the enforcement scripts and test, and write a brief `setup-notes.md` documenting what you set up and how to activate it.

## Output Specification

Produce the following files:

1. `.git-hooks/pre-push` — A shell script that acts as a git pre-push hook, running lint and smoke checks. It must be executable.

2. `e2e/cli.test.sh` — A shell script that runs the CLI against a real input file and verifies the output is correct (e.g., using diff against an expected output file or checking for expected content). Include the fixture input file it uses.

3. `e2e/fixtures/sample.csv` — Sample CSV input used by the e2e test.

4. `e2e/fixtures/expected.json` — Expected JSON output corresponding to sample.csv.

5. `setup-notes.md` — Brief documentation explaining: (a) how to activate the git hook, (b) what the dead-code check command is for this TypeScript project, and (c) what the e2e test covers.

## Input Files

The following files represent the current state of the project. Extract them before beginning.

=============== FILE: package.json ===============
{
  "name": "csv-to-json-cli",
  "version": "2.1.0",
  "description": "Convert CSV files to JSON",
  "bin": {
    "csv2json": "./dist/cli.js"
  },
  "scripts": {
    "build": "tsc",
    "lint": "eslint src/",
    "test": "jest"
  },
  "dependencies": {},
  "devDependencies": {
    "typescript": "^5.0.0",
    "eslint": "^8.0.0",
    "@typescript-eslint/parser": "^6.0.0",
    "jest": "^29.0.0",
    "ts-jest": "^29.0.0"
  }
}

=============== FILE: src/cli.ts ===============
#!/usr/bin/env node
import { readFileSync, writeFileSync } from 'fs';
import { parseCsv } from './parser';

const [,, inputFile, outputFile] = process.argv;

if (!inputFile) {
  console.error('Usage: csv2json <input.csv> [output.json]');
  process.exit(1);
}

const csv = readFileSync(inputFile, 'utf-8');
const result = parseCsv(csv);

if (outputFile) {
  writeFileSync(outputFile, JSON.stringify(result, null, 2));
} else {
  console.log(JSON.stringify(result, null, 2));
}

=============== FILE: src/parser.ts ===============
export function parseCsv(csv: string): Record<string, string>[] {
  const lines = csv.trim().split('\n');
  const headers = lines[0].split(',').map(h => h.trim());
  return lines.slice(1).map(line => {
    const values = line.split(',').map(v => v.trim());
    return Object.fromEntries(headers.map((h, i) => [h, values[i] ?? '']));
  });
}

export function legacyParseCsv(csv: string): string[][] {
  // Old implementation kept for reference but no longer used
  return csv.split('\n').map(line => line.split(','));
}

=============== FILE: src/parser.test.ts ===============
import { parseCsv } from './parser';

jest.mock('./parser', () => ({
  parseCsv: jest.fn(),
  legacyParseCsv: jest.fn()
}));

test('parseCsv is a function', () => {
  expect(typeof parseCsv).toBe('function');
});

=============== FILE: tsconfig.json ===============
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "outDir": "./dist",
    "strict": true
  },
  "include": ["src/**/*"]
}

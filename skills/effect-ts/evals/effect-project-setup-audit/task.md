# Task: Audit and Fix an Effect TypeScript Project Setup

A junior developer has started a new Effect TypeScript project, but the configuration has several problems. Your job is to audit the project and produce a corrected configuration.

## Output Specification

Produce the following files at the workspace root, ready to commit as-is (no placeholders left unfilled):

1. A corrected `package.json` (keep all existing app dependencies; only fix Effect-related packages and scripts)
2. A corrected `tsconfig.json`
3. A `.vscode/settings.json` with the recommended TypeScript settings for this kind of project
4. An `AUDIT.md` explaining each problem found and what was changed

## Input Files

The following files represent the current state of the repository. Extract them before beginning. The project targets the Node.js runtime.

=============== FILE: package.json ===============
{
  "name": "scenario-2-project",
  "version": "0.1.0",
  "type": "module",
  "scripts": {
    "start": "tsx src/index.ts",
    "build": "tsc"
  },
  "dependencies": {
    "effect": "^3.10.0",
    "@effect/schema": "^0.75.0",
    "@effect/platform": "^0.69.0",
    "@effect/platform-node": "^0.64.0",
    "@effect/platform-bun": "^0.49.0"
  },
  "devDependencies": {
    "typescript": "^5.6.0",
    "tsx": "^4.19.0"
  }
}

=============== FILE: tsconfig.json ===============
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ES2022",
    "moduleResolution": "bundler",
    "esModuleInterop": true,
    "skipLibCheck": true,
    "strict": false,
    "outDir": "./dist",
    "rootDir": "./src"
  },
  "include": ["src/**/*"]
}

=============== FILE: src/index.ts ===============
import { Effect } from "effect"

const program = Effect.succeed("hello, world")

Effect.runSync(program)

## Known Issues to Investigate

The current `package.json` includes:
- `@effect/schema` as a direct dependency
- both `@effect/platform-node` and `@effect/platform-bun` installed
- no test framework

The current `tsconfig.json` has:
- `"strict": false`
- no `exactOptionalPropertyTypes`
- no `verbatimModuleSyntax`
- no `@effect/language-service` plugin

Fix all issues you find by applying standard Effect project conventions.

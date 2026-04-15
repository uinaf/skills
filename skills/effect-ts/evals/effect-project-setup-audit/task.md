# Task: Audit and Fix an Effect TypeScript Project Setup

A junior developer has started a new Effect TypeScript project, but the configuration has several problems. Your job is to audit the project and produce a corrected configuration.

## Project Location

The project files are at `/workspace/scenario-2-project/`. The relevant files are:

- `package.json` — lists dependencies and scripts
- `tsconfig.json` — TypeScript compiler configuration
- `.vscode/settings.json` — VS Code workspace settings (may or may not exist)
- `src/index.ts` — application entrypoint (for reference)

## What to Produce

1. Write a corrected `package.json` to `/workspace/scenario-2-project/package.json` (keep all existing app dependencies; only fix Effect-related packages and scripts)
2. Write a corrected `tsconfig.json` to `/workspace/scenario-2-project/tsconfig.json`
3. Write a VS Code workspace settings file to `/workspace/scenario-2-project/.vscode/settings.json` with the recommended TypeScript settings for this kind of project
4. Write an audit report to `/workspace/scenario-2-project/AUDIT.md` explaining each problem found and what was changed

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

Fix all issues you find by applying standard Effect project conventions. The project targets the Node.js runtime.

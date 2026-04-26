# Per-project AGENTS.md template

Language- and framework-specific defaults extracted from the previous global `rules/AGENTS.md`. Copy the sections that apply into a project's own `AGENTS.md` so the global file can stay short.

## TypeScript

- No escape hatches: no `as` casts, no non-null `!`, no `unknown as T`, no double assertions unless explicitly approved
- Parse external data with a schema library at the boundary; operate on typed structures internally

## Tests

- Mock real timers; never `setTimeout`/`Date.now` against the wall clock in tests
- Do not assert on logger calls; mute loggers in test suites
- Prefer in-process tests: expose callable entry functions and test those directly. Reach for subprocess tests only for true process-boundary behavior
- Coverage must represent executed production code for the full test run, not synthetic loaders or fixtures

## Performance

- For hot paths or perf-sensitive changes, include before/after benchmark numbers in the PR

## Markdown style

- Never put a period directly after a code span, URL, or code block

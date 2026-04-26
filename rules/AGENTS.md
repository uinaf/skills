# Agent Guidelines

Behavioral guidelines for AI coding agents. Merge with project-specific instructions.

> Synced via [`sync/pull.sh`](../sync/pull.sh) into `~/.claude/CLAUDE.md`, `~/.codex/AGENTS.md`, `~/.pi/agent/AGENTS.md`. For repo contributor guidance, see [`AGENTS.md`](../AGENTS.md). For language- and framework-specific defaults to copy into a project, see [`templates/per-project-AGENTS.md`](templates/per-project-AGENTS.md).

---

## Core Behavior

- Lead with the answer, then reasoning. Cite file paths, command output, errors
- Fix only what was asked. Flag related issues, wait for approval before expanding scope
- If instructions are unclear, contradictory, or have multiple plausible interpretations, ask before guessing
- When rules conflict: safety/correctness > explicit user constraints > style/tone

---

## Workflow

### Plan before code

A task is non-trivial if it touches multiple files, changes a public contract, touches persistence/external I/O, or needs new tests or migrations. Trivial tasks skip planning.

For non-trivial tasks, before writing code:

1. Read the current code, docs, and contracts you'll touch
2. Confirm what changes, what must NOT change, and what "done" looks like
3. Write a short plan: what, where, why, verification, non-goals
4. If the plan has unresolvable ambiguities or breaks mid-flight, stop and surface — don't guess

### Verification

- Bug fix → write a reproducing test first, then fix
- Refactor → confirm before/after behavior parity
- Feature → contract-level tests plus a runtime check (run the binary, hit the endpoint, read the output)
- Fresh worktree → bootstrap (install deps, codegen) before running checks
- Use repo guardrails (`make verify`, `just verify`) when present; otherwise run format, lint, typecheck, test explicitly
- Prefer integration / contract / e2e checks over mock-heavy unit tests
- If verification infra is missing, flag it (use `agent-readiness`) — do not declare done
- The builder never grades their own work. Hand verification to an independent evaluator (e.g. `verify` skill or a fresh subagent)

### Feedback loops

- Lint, format, typecheck, push hooks are deterministic gates — never substitute agent judgment for them
- Cap retries at 2 CI rounds per change; partial success beats infinite retry
- Run independent concerns as parallel subagents; do not serialize what can fan out

### Keep docs alive

- After a feature, rename, move, or delete: grep `AGENTS.md`, `README`, and architecture docs for stale references and update them in the same change

### When blocked

Reproduce the failure, find the root cause with evidence, fix the root cause. No `--no-verify`, no skipped tests, no workarounds without explicit approval. In autonomous mode, surface the blocker rather than burning tokens speculating.

---

## Code Principles

- Build from small composable pieces with narrow surfaces; deep modules over layered complexity
- Make illegal states unrepresentable; parse external input at the boundary, operate on typed values internally
- Delete dead code, unused exports, stale branches — do not preserve "just in case"
- Follow existing repo conventions before inventing new ones; if you must invent, explain why
- Never hardcode volatile metrics (test counts, coverage %) in docs — let commands be the source of truth
- Use repo-relative links in checked-in Markdown; never commit absolute filesystem paths
- Do not disable linters, type checks, or tests — fix the root cause
- Treat errors as first-class: typed, contextful, no silent catches
- Never log or surface secrets in error output
- Schema/state changes must be forward-compatible with a documented rollback path; flag irreversible migrations before running them
- Don't add dependencies unless necessary; prefer what's already in the stack

---

## Commit Gate

- All checks green before commit
- Conventional Commits: `<type>(<scope>): <subject>`. Mark breaking changes with `!` or a `BREAKING CHANGE:` footer
- Commit only the scoped change; leave unrelated diffs out
- For non-trivial changes, the PR body lists Changed (files + intent), Risks (what to verify), and Complexity (reduced / neutral / increased — justify if increased)

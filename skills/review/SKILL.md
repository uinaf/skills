---
name: review
description: "Independently audit existing code, diffs, branches, or pull requests using concern-specific reviewer personas and evidence. Use when triaging risk in a PR, deciding whether a change is safe to ship, or following up on a `verify` pass to make the call the builder cannot make on their own work. Produces a `ship it` / `needs review` / `blocked` verdict. Do not use to self-check a change you just authored; use `verify` for that."
---

# Review

Independently audit existing code with concern-specific lenses and decide whether it is safe to ship. Review is the gate after `verify` — the builder proves the change works on the real surface, then review decides whether the change is *good*.

## Principles

- Prefer parallel reviewer personas when the concerns are independent
- Evidence beats taste
- Load shared doctrine from the target repo's guidance files such as `AGENTS.md`, `CLAUDE.md`, or repo rules
- Keep the final verdict tied to concrete evidence, not reviewer instinct alone
- Keep findings risk-focused; do not drown the user in low-value nits
- Track the reviewer personas you used; include them in the visible answer only when the user asks or the harness has a compact metadata field
- Always include an explicit `unverified areas` line, even if the answer is `none`
- Always choose the verdict from exactly: `ship it`, `needs review`, `blocked`
- If runtime proof for your own completed change is the goal, hand off to `verify`

## Handoffs

- Self-checking a change you just authored, before handing it off for review → use `verify`
- Review is blocked because the repo cannot be booted or exercised reliably → use `agent-readiness`
- Main problem is stale AGENTS.md, README, specs, or repo docs → use `docs`

## Before You Start

1. Define the scope: file, diff, branch, commit range, or PR
2. Load the target repo's guidance files such as `AGENTS.md`, `CLAUDE.md`, or repo rules, when present
3. Choose reviewer personas from [references/reviewer-selection.md](references/reviewer-selection.md)
4. Decide which personas can run independently in parallel

Default personas:

- [reviewers/general.md](reviewers/general.md)
- [reviewers/tests.md](reviewers/tests.md)
- [reviewers/silent-failures.md](reviewers/silent-failures.md)

Add conditional personas only when they earn their keep:

- [reviewers/types.md](reviewers/types.md)
- [reviewers/cleanup.md](reviewers/cleanup.md)
- [reviewers/comments.md](reviewers/comments.md)

Persona shortcuts:

- doc-only or comment-only diffs: use `general` plus `comments`; skip `tests`, `types`, `silent-failures`, and `cleanup` unless the diff actually justifies them
- type-shape or schema changes: add `types`
- dead files, deprecated paths, or obviously unused helpers: add `cleanup` and call out deletion explicitly when warranted
- mock-heavy or shallow tests around risky behavior: make that a finding rather than treating test presence as proof

## Workflow

### 1. Scope nearby risk

Review the requested code, but inspect adjacent behavior when the risk leaks past the named diff.

### 2. Run reviewer personas

Use parallel subagents when available. Keep each persona concern-focused and independent.

Concrete starting points:

- `git diff --stat <base>...HEAD` to size the change
- `git diff <base>...HEAD -- <path>` to inspect risky files
- targeted tests such as `pnpm test path/to/spec` when behavior claims need proof

### 3. Collect evidence

- Cite exact file references for static findings
- Run the smallest runtime check that changes the verdict when the repo supports it
- If something is unverified, say so explicitly instead of bluffing
- If legacy or dead code is still present, say whether it should be deleted or why it must stay
- If tests mock the main integrations or boundaries, say that the behavior is still unverified on the real surface

### 4. Synthesize the verdict

Produce one clear outcome:

- `ship it`
- `needs review`
- `blocked`

Order findings by severity. If no findings are discovered, say that explicitly and mention any residual risk or testing gap.

## Output

After review, report a tiny verdict footer:

- verdict
- evidence summary: exact command names or runtime surfaces, not full logs
- unverified areas or readiness gaps
- next: implementation, `verify`, `agent-readiness`, or `docs`

Use those labels explicitly. Do not replace them with softer prose like "safe to merge" or "do not ship today".

Prefer the active harness's best native review representation instead of a prose-heavy wall of text.

Keep the final answer short:

- Put detailed issue text, file references, and line numbers in native findings or the fallback findings list
- Do not repeat native finding details in the verdict block
- Keep the verdict footer to 4 labeled lines or fewer
- Keep each label to one sentence; use comma-separated command names instead of log excerpts
- Omit scope and personas from the footer unless the user asked for them or the scope would be ambiguous without one short `reviewed:` line
- If there are no findings, say `findings: none` and keep the rest equally compact

Harness-specific presentation rules:

- Prefer the strongest structured finding format available: Codex/OpenAI native `P0` / `P1` / `P2` / `P3` cards, or a compact table in Claude/Anthropic harnesses
- If no richer primitive exists, use a short severity-ordered findings list with file/line, issue, impact, and evidence
- Never hide actionable findings inside the footer or a long prose recap

Example:

```text
verdict: needs review
finding: high — src/auth/session.ts:42 fallback returns an anonymous session when token parsing fails
evidence: pnpm test src/auth/session.test.ts
unverified areas: runtime behavior for malformed OAuth callbacks
next: implementation
```

## References

- [references/reviewing.md](references/reviewing.md) — reviewer persona workflow, evidence expectations, and verdict synthesis
- [references/reviewer-selection.md](references/reviewer-selection.md) — which reviewer personas to run for which change shapes
- [reviewers/](reviewers/) — specialized review lenses

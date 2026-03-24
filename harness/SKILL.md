---
name: harness
description: "Evaluate, set up, and improve a project's agent-testable verification infrastructure. Use when asked for a harness audit, harness grade, or when a repo has no bootable dev environment, no integration tests, or no interaction layer an agent can use. Not for per-change verification (use verify for that)."
---

# Harness

Build the verification infrastructure that coding agents use to prove their work.

**Harness builds the tools. Verify uses them.**

## The 7-Layer Stack

Every harness has these layers. Name them when grading — "we have layers 1-3, missing 4-7":

1. **Boot** — single command starts the app. Docker Compose for complex stacks
2. **Smoke** — app is alive (health endpoint, home page, `--version`). Under 5 seconds
3. **Interact** — agent can exercise the app (Playwright CLI for UI, curl for APIs, shell scripts for CLIs)
4. **E2e** — key user flows on real surfaces (not mocks)
5. **Enforce** — git hooks, CI gates, custom lint rules with agent-readable error messages
6. **Observe** — structured logs, health endpoints, error traces queryable by agent
7. **Isolate** — per-worktree or per-container, parallel agents don't collide

## When to Use

- New repo with no dev environment an agent can boot
- Agent can write code but can't see what it built
- No integration or e2e tests — only mocked unit tests
- `verify` keeps reporting harness gaps it can't fill
- Periodic harness health check or grade requested

## Workflow

### 1. Evaluate

Inspect the repo and grade across four dimensions. For each, record `status` (pass / partial / fail), `evidence` (specific file or command), and `gap` (what's missing).

**Bootable** — Can an agent start the app with one command and confirm it's running?

**Testable** — Do tests exercise the real running app, not just mocks? Distinguish:
- *Smoke tests*: app is alive. Under 5 seconds
- *E2e tests*: key user flows work (Playwright, API round-trips, golden files)
- Detection: check for `jest.mock`, `vi.mock`, `unittest.mock` at test file level. Mock-only tests score zero

**Observable** — Can the agent query structured logs, health endpoints, or error traces?

**Verifiable** — Can the agent produce evidence (screenshots, response logs, traces)?

Use parallel subagents for evaluation: one per dimension, merge findings.

Grade using `references/grading.md`

### 2. Act

Based on grade:
- **Grade F–D**: Set up. Build missing layers in priority order (Boot → Smoke → Interact → E2e → Enforce → Observe → Isolate)
- **Grade C+**: Improve. Identify highest-value gap, implement one improvement per pass

Each piece should be independently useful — stop after any step if remaining gaps aren't blocking.

### 3. Separate Builder from Judge

Self-evaluation is unreliable. When the project needs quality grading beyond "does it boot":
- Spawn a separate evaluator subagent that navigates the running app, screenshots, and grades against criteria
- The builder agent should never grade its own output
- See `references/examples.md` for the Anthropic evaluator and Stripe patterns

## Subagents

Use subagents for harness work:
- **Evaluation lanes**: one subagent per dimension (bootable, testable, observable, verifiable) — parallel, merge findings
- **Evaluator subagent**: independent from builder, navigates running app, produces evidence
- **Setup subagents**: when building multiple layers, parallelize independent ones (e.g., Playwright setup and structured logging can run simultaneously)

Subagents are context firewalls — each gets only the context relevant to its concern.

## Principles

- **Environment > instruction** — the harness matters more than the prompt
- **Mechanical enforcement > documentation** — git hooks, CI gates, lint rules > prose in AGENTS.md
- **Separate builder from judge** — self-evaluation is unreliable
- **Deterministic where possible, agentic where needed** — lint/push/format hardcoded, implementation/fix agentic
- **Cap retries** — max 2 CI rounds, partial success > infinite retry
- **Scoped rules over global rules** — rules per subdirectory/file pattern, not global dump. Agents pick up what's relevant as they navigate
- **CLI > MCP for standard tools** — exception: MCP when interactive agent navigation is needed
- **Progressive disclosure** — small entry point, load detail on demand

## Handoff to Verify

When harness work is complete, hand off to the `verify` skill:
- **Grade C+**: verify can run basic checks (boot + smoke + some interaction)
- **Grade B+**: verify can run full lanes (e2e, screenshots, structured log queries)
- **Grade D/F**: verify results are unreliable — fix harness first

Verify expects: bootable command, interaction layer, observable logs. If any are missing, verify will report harness gaps.

## Anti-Patterns

- Mocked tests counting as a harness — they pass by construction, verify nothing
- Self-evaluation — agent grades own work, always passes
- Global AGENTS.md dump — fills context before work starts. Scope rules per directory
- Infinite retry loops — max 2 CI rounds, then hand back with partial result
- All-agentic pipeline — lint/push/format should be deterministic, not LLM-decided

## References

- `references/grading.md` — harness quality grading scale with mechanical criteria
- `references/patterns.md` — concrete setup patterns by project type
- `references/examples.md` — real-world harness examples (OpenAI, Anthropic, Stripe)

## Output

After any harness work, report:

- **Grade**: before and after (if changes made)
- **Layers**: which of the 7 layers exist, which are missing
- **Dimensions**: bootable / testable / observable / verifiable — each with status + evidence
- **What changed**: specific files added or modified
- **Gaps**: remaining gaps ranked by impact
- **Next step**: single highest-value improvement remaining
- **Verify readiness**: can `verify` run now? (C+ = yes, D/F = no)

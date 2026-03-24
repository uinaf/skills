---
name: verify
description: "Reality-check code after tests pass. Use when finishing a feature, bug fix, refactor, code review, or when asked to verify something works end to end."
---

# Verify

**The agent that wrote the code should never verify it.** Self-evaluation is unreliable — spawn an independent evaluator. This is why verify exists as a separate skill.

Passing tests is necessary, not sufficient. Use the project's harness (bootable env, interaction layer, observability) to prove the change works. If no harness exists, run the `harness` skill first — don't improvise a one-off check and call it verified.

## Before You Start

1. Check harness grade: C+ = proceed with checks. D/F = stop and invoke `harness` first
2. Can you boot the app? (dev server, Docker Compose, or equivalent)
3. Can you interact with it? (Playwright CLI for UI, curl for APIs, CLI invocation)
4. If not, flag the gap as a harness issue

## Rules

- If you did not run it, you did not verify it
- Verify outcomes, not prompt compliance
- For non-trivial changes, check nearby flows and likely regressions, not just the exact diff
- Prefer tools established by the harness: Playwright CLI for UI, curl/httpie for APIs, standard test runners. CLI > MCP for standard tools
- Record the commands and artifacts so another agent can repeat the check
- **Max 2 verification cycles.** If still `needs review` after two passes, escalate — don't loop indefinitely

## Subagents

**Why subagents:** context firewalls. Each subagent gets only the context for its concern — prevents context pollution and rot. This is the primary reason to split, not just speed.

**When to split:** work divides cleanly by concern, lanes are independent, context is large enough to benefit from isolation.

**When NOT to split:** lanes depend on each other's output, context is small, or overhead of coordination exceeds benefit.

For named lanes, model guidance, and what each lane should look for, see `references/subagent-lanes.md`

**Evaluator pattern (heavy verification):** Spawn a separate evaluator subagent that navigates the running app with Playwright/CDP, takes screenshots, and grades against predefined criteria. This is the canonical pattern for UI and interactive verification — the evaluator is always independent from the builder.

## Checks

### 1. Real Surface
- Run the shipped CLI, service, job, or UI flow with representative inputs
- For UI, use Playwright CLI or CDP — inspect behavior, structure, legibility, responsiveness
- For services, hit the real local endpoint and confirm the full round trip

### 2. Change Review
- Screenshots are evidence, not the verdict
- If the result is weak, fix it and re-run verification
- Check nearby surfaces and follow-on states, not just the named change
- If one perspective is too narrow, use independent subagent lanes and merge the findings

### 3. External Contracts
- Verify field names, enums, and response shapes against docs or real responses
- If you cannot verify a contract detail, stop and surface the gap

### 4. State and Config
- Verify public interfaces still work end to end
- Verify persistence/state round trips with real data where relevant
- Verify config changes by starting the program with the new config

### 5. CI Integration
- If the project has CI, push and wait for results before declaring `ship it`
- CI failures after verify = verify missed something. Investigate, don't dismiss

### 6. Smell Test
- Check that outputs look plausible to a human
- **Investigate anything odd instead of rationalizing it** — this is the specific failure mode. Look for: unexpected empty states, wrong user names, stale data, UI elements from the wrong route, truncated responses, hardcoded test values in production output
- The agent's tendency to rationalize rather than investigate is what this check prevents

### 7. Proof of Work
- Use the harness's observability layer: query structured logs, health endpoints, error traces
- Keep screenshots, response logs, traces, sample responses, generated files
- Evidence should be reproducible — include the exact commands

## Output

Report:

- `Verified`: what you checked
- `Commands`: what you ran
- `Artifacts`: what evidence you inspected
- `Gaps`: what you could not verify
- `Confidence`: `ship it` / `needs review` / `blocked`
- `Harness gaps`: verification infra that was missing or insufficient (feeds back to `harness`)

---
name: docs
description: "Keep project docs useful for humans and agents. Use when creating or updating README, AGENTS, architecture docs, plans, or doing a docs audit."
---

# Docs

Keep the repo legible to humans and agents.

## Use It For

- Creating or updating `README.md`, `AGENTS.md`, architecture docs, guides, decisions, or plans.
- Auditing docs after code changes.
- Turning chat knowledge into durable repo knowledge.

## Avoid

- Turning `AGENTS.md` into a manual.
- Turning `README.md` into a full project handbook.
- Putting every detail in `SKILL.md` instead of routing to deeper docs or `references/`.
- Writing long prose when a table, diagram, pseudocode block, or check would work better.
- Leaving durable guidance in chat, tickets, or external docs.
- Keeping stale plans or duplicated instructions around.

## Defaults

- `README.md`: human-facing overview, setup, usage, contributing.
- `AGENTS.md`: short routing layer for agents; exact commands and links to deeper docs.
- `docs/ARCHITECTURE.md`: diagram-first system view and important boundaries.
- `docs/*.md`: task-specific durable references such as API, deployment, guides, and decisions.
- `docs/plans/*.md`: one plan per feature with goal, design, tasks, and validation hooks for autonomous execution.
- For README patterns and examples, read `references/readme-examples.md`.

## Workflow

1. Inspect the repo and current docs first.
2. Keep `README.md` and `AGENTS.md` short. Move task-specific detail into `docs/*`. For README work, pick a shape from `references/readme-examples.md`.
3. Keep `SKILL.md` to triggers and workflow; move heavier detail to `references/` when it helps repeated use.
4. Update only the docs touched by the change, and ground claims in the repo or command output.
5. Record boot steps, validation steps, and handoff details in plans when they matter.
6. Delete or archive stale plans, duplicated guidance, and AI slop.
7. If drift keeps recurring, add a check or template instead of another paragraph.

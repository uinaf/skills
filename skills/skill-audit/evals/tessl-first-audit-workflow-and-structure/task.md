# Skill Audit: Onboarding Assistant Skill

## Problem/Feature Description

A platform team has been maintaining a growing library of agent skills. One of their oldest skills — `onboarding-assistant` — was written before the team adopted any formal quality standards. It recently started showing poor activation rates: users keep forgetting to invoke it, and when they do, the agent sometimes goes off-script. The team lead has asked you to do a thorough audit of the skill and produce a written report that the team can use to decide which issues to fix first.

The skill lives in the `skills/onboarding-assistant/` folder of the repo provided below. The repo also contains a `AGENTS.md` with team conventions. Your job is to audit the skill using the Tessl CLI, evaluate it against standard skill-authoring criteria, and write up what you find.

## Output Specification

Produce a file called `audit-report.md` in the working directory. The report must cover:

- Which Tessl command you ran and the resulting score
- The strongest parts of the skill as it stands
- A prioritized list of findings, each referencing the specific file and section where the problem appears
- The smallest set of changes that would address the highest-priority issues
- Whether you reran Tessl after making any edits, and if so, what changed

Also produce a file called `audit-log.sh` containing the exact shell commands you ran during the audit (Tessl invocations, any file reads, etc.), in execution order.

## Input Files

The following files are provided as inputs. Extract them before beginning.

=============== FILE: skills/onboarding-assistant/SKILL.md ===============
---
name: onboarding-assistant
description: Helps new employees get started.
---

# Onboarding Assistant

This skill helps. When someone joins the company, use this to help them.

## What to do

Help the user with onboarding. You can:
- Answer questions about the company
- Help set up their laptop
- Explain the codebase

Be helpful and friendly. Make sure they feel welcome. Try your best to assist with whatever they need.

If there are documents, read them. If there are scripts, run them. Good luck!

=============== FILE: AGENTS.md ===============
# Team Conventions

- Skill frontmatter must contain only `name` and `description`
- All local file links in Markdown must be repo-relative
- Practical, task-specific examples are required in skills that have complex workflows
- After any skill edit, re-run Tessl and record the new score
- Do not use the optimizer unless a team lead explicitly approves it

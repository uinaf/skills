# Simplification

Use this reference after behavior is proven, not instead of behavior proof.

The goal is to challenge the changed code for unnecessary complexity before calling the work done.

## Scope

- Focus on files touched in the current task
- Expand only when the changed code clearly exposes nearby duplication or confusion that should be cleaned up now
- Preserve behavior exactly; this is a shape pass, not a feature rewrite

## Questions

Ask these in order:

1. Does the implementation match the language, framework, and design patterns already used in this repo?
2. Is any part of the solution duplicated, nearly duplicated, or split across helpers that should be one explicit path?
3. Are there abstractions, wrappers, or helpers that exist only to make generated code look organized?
4. Would removing comments make the code harder to understand, or would clearer naming and structure remove the need for them?
5. If a brand new agent opened this file tomorrow, could it follow the flow and safely extend it without reverse-engineering hidden intent?

## Improve

- Prefer explicit names over explanatory comments
- Prefer one obvious control flow over dense indirection
- Prefer deleting dead branches and duplicate helpers over preserving them "just in case"
- Prefer local consistency with the repo over importing a new pattern from memory
- Prefer fewer concepts, not just fewer lines

## Avoid

- "Simplifying" by compressing logic into clever one-liners
- Extracting helpers that hide rather than clarify intent
- Keeping comments that merely narrate what the code already says
- Large speculative rewrites when the shape problem is local

## Evidence

When this pass finds issues, tie them to one of these:

- duplicated logic or near-duplicates
- comments that reveal unclear structure
- abstractions that add indirection without protecting a boundary
- naming or control flow that a fresh agent would struggle to follow

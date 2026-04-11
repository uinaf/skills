# Testing

Use this reference when migrating tests to VitePlus-native usage.

## Defaults

- Prefer imports from `vite-plus/test` over direct `vitest` imports when migrating to VitePlus.
- Move coverage and test-command wiring together with script updates.
- Verify both the default test pass and any coverage mode the repo actually depends on.
- Use `vp test` rather than attempting to invoke Vitest through a made-up subcommand.

## Caveat

At the time this skill was written, adding `@vitest/coverage-v8` to a VitePlus project can still produce a mixed-version warning during `vp test --coverage`, even in a fresh stock scaffold. Treat that as a VitePlus limitation to verify and document, not as an automatic repo regression.

# Commands

Use this reference before changing command invocations, package-manager usage, or script wiring in a Vite+ repo.

## Defaults

- Treat `vp` as the tool owner for runtime, package-manager, and frontend-tooling operations.
- Do not use `pnpm`, `npm`, or `yarn` directly when Vite+ is the tool owner; use `vp install`, dependency subcommands, or `vp pm` instead.
- Do not invent nonexistent commands such as `vp vitest` or `vp oxlint`; use the built-in `vp test` and `vp lint` commands.

## Built-ins vs Scripts

- Built-in commands such as `vp build`, `vp test`, and `vp dev` do not run same-named `package.json` scripts.
- Use `vp run <script>` for repo-defined scripts that Vite+ does not replace directly.
- If a task needs caching, dependency ordering, or environment/input control, define it in the `run` block in `vite.config.ts` instead of leaving it as a plain package script.

## Validation Path

- Prefer the standard migration validation sequence: `vp env`, `vp install`, `vp check`, `vp test`, then `vp build` or `vp pack` as appropriate.

# Packages

Use this reference for standalone package repos adopting VitePlus.

## Defaults

- Prefer `vp pack` for libraries and executables.
- Prefer `vp check` and `vp test` as the default verify surface.
- Keep `pack` config in `vite.config.ts` when feasible instead of maintaining a parallel tsdown config.

## Notes

- `pnpm` repos should add overrides for VitePlus-wrapped `vite` and `vitest`.
- Keep SDK, codegen, or bootstrap steps that VitePlus does not replace.
- Update docs when install, test, or packaging commands change.

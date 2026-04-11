# CI/CD

Use this reference before changing GitHub Actions or release automation.

Prefer the documented VitePlus setup:

```yaml
- uses: voidzero-dev/setup-vp@v1
- run: vp env
- run: vp install
- run: vp check && vp test
```

## Defaults

- Prefer `voidzero-dev/setup-vp@v1` over hand-rolled Node/Corepack bootstrapping unless the repo has a proven exception.
- Prefer `vp install` over separate package-manager bootstrap logic when VitePlus is the tool owner.
- Prefer `vp config` when the repo wants stock hooks or agent integration instead of hand-rolled hook setup.
- Prefer one repo-local verify entrypoint if CI needs extra repo-specific commands.
- Keep release orchestration in GitHub Actions when the repo has npm, GitHub Release, binary, or Homebrew automation that goes beyond stock VitePlus.

## Guardrails

- Prefer `vp run <script>` when CI needs a repo-specific script that VitePlus does not replace.
- Do not delete release-only steps just to make the workflow look more stock.
- Keep packaging and publish steps that VitePlus does not own.

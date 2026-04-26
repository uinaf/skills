# Preserve the Working Deploy Workflow Shape

## Problem/Feature Description

The `uinaf-site` repo needs its Cloudflare Pages deploy workflow restored after a failed refactor. A previous attempt replaced the repo's composite deploy action with a marketplace action and moved the smoke check before the deploy finished, which made the workflow green while production was still serving the old build.

The organization already has a known-good sibling repo, `uinaf-console`, that deploys the same kind of Vite-built app through a local composite action. It uploads the build artifact in verify, downloads that exact artifact in e2e and deploy, then runs `curl -fsS` against the deployed URL.

## Output Specification

Produce `.github/workflows/main.yml` and `.github/actions/cloudflare-pages-deploy/action.yml` for `uinaf-site`.

Preserve the sibling pattern: local composite action, artifact pass-through, and post-deploy smoke check. Do not introduce a new marketplace deploy action unless you explain why the sibling composite action does not fit.

## Input Files

The following files represent the current repository state. Extract them before beginning.

=============== FILE: package.json ===============
{
  "scripts": {
    "build": "vite build",
    "test:e2e": "playwright test"
  },
  "devDependencies": {
    "@cloudflare/wrangler": "latest",
    "@playwright/test": "latest",
    "vite": "latest"
  }
}
=============== END FILE ===============

=============== FILE: docs/uinaf-console-cloudflare-deploy-action.yml ===============
name: cloudflare-pages-deploy
inputs:
  api-token: { required: true }
  account-id: { required: true }
  project-name: { required: true }
  dist-dir: { required: true }
  branch: { required: true, default: main }
runs:
  using: composite
  steps:
    - shell: bash
      env:
        CLOUDFLARE_API_TOKEN: ${{ inputs.api-token }}
        CLOUDFLARE_ACCOUNT_ID: ${{ inputs.account-id }}
      run: |
        npx wrangler@latest pages deploy "${{ inputs.dist-dir }}" \
          --project-name "${{ inputs.project-name }}" \
          --branch "${{ inputs.branch }}"
=============== END FILE ===============

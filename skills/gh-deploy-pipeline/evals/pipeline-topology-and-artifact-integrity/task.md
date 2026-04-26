# Reliable GitHub Actions Deploy Pipeline for a React SPA

## Problem/Feature Description

Nexus Labs runs a React SPA (built with Vite) that is currently deployed by hand: a developer runs `npm run build` locally and drags the `dist/` folder to the Cloudflare Pages dashboard. This works when there is only one developer, but the team has grown to seven engineers and two of them broke production last week by shipping untested local builds. The team wants a GitHub Actions pipeline that enforces the rule "what was tested is exactly what gets deployed" — no exceptions.

The pipeline should build the app once, run end-to-end tests against that exact build output, and only then ship it to Cloudflare Pages. If the build produces no output (which happened silently twice this month due to a misconfigured Vite output path), the pipeline must catch it immediately. The app uses a Vite-based framework with a non-standard output structure. After every successful deployment, on-call engineers must be able to confirm that the live site is serving traffic correctly — right now there is no automated check and the team only finds out about broken deploys from user reports.

## Output Specification

Produce a working GitHub Actions workflow at `.github/workflows/main.yml` that triggers on push to `main` and implements the full build → test → deploy flow described above. Also create the Cloudflare Pages composite action at `.github/actions/cloudflare-pages-deploy/action.yml`.

The workflow must reference `vars.CLOUDFLARE_ACCOUNT_ID` and `secrets.CLOUDFLARE_API_TOKEN` for Cloudflare credentials.

Include a brief `deploy-summary.md` file explaining the pipeline shape you chose — what runs in each job, what gets passed between jobs, and why.

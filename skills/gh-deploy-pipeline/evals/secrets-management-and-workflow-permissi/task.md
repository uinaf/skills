# Secure Secrets and Credentials Wiring for a GitHub Actions Deploy Pipeline

## Problem/Feature Description

Orbital Systems is migrating a Node.js API service from a manual VPS deployment process to GitHub Actions. The service connects to a PostgreSQL database, calls the Stripe API, and uses several internal service tokens. A previous attempt to automate the deployment stored these connection strings and API keys directly in GitHub repository secrets and passed them to the container via the workflow YAML. A security audit flagged this setup: secrets were visible in workflow logs, rotation required updating multiple repositories manually, and there was no clear separation between the credentials the CI system needs to operate and the credentials the running application needs.

The team uses AWS as its cloud provider. The VPS runs containers managed with Docker and Traefik. The application's 1Password vault (`shared-prod`) already contains all the runtime credentials under the vault path format. The goal is to redesign the secrets and credentials wiring so that long-lived cloud credentials are eliminated from the GitHub secret store, runtime application secrets come from 1Password, and nothing sensitive ever appears in logs or workflow YAML.

## Output Specification

Produce the following files:
- `.github/workflows/main.yml` — the push-to-main deploy workflow with correct permissions, OIDC auth, and 1Password secret loading
- `.github/actions/load-1password-env/action.yml` — the composite action that renders the env file from 1Password
- `deploy/production.env.example` — the committed env template file with `op://` references (use plausible but fictional vault paths)
- `secrets-design.md` — an explanation of what each credential category is, where it lives, and why, including what goes in GitHub secrets vs. 1Password vs. `vars.*`

Do not include any real credentials or tokens in the files.

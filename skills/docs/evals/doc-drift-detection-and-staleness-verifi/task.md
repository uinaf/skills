# Fix Documentation Drift After a Backend Refactor

## Problem/Feature Description

The backend team at Fieldstone Labs recently completed a major refactor of their `invoicing-service`. Over three sprints they renamed scripts, moved configuration files, restructured the API, and removed a feature. The code is in good shape, but nobody updated the docs. Now the DevOps team is getting paged because new engineers are running commands from `AGENTS.md` and `README.md` that no longer exist, and the on-call runbook references an endpoint that was deleted in the refactor.

Your job is to audit the documentation against the actual repository state, identify every stale reference, and fix the documentation so it accurately reflects what's really in the codebase. Be systematic — don't just fix what looks obviously wrong, check every command and file path mentioned in the docs against what actually exists.

## Output Specification

Produce the following:
- Updated versions of any documentation files that need changes (overwrite them in place)
- `doc-audit.md` — a structured report listing every stale reference found, what it pointed to, what it actually should point to (or that it should be removed), and confirmation that you verified the correct target exists

Do not fix anything you haven't verified — if you're not sure whether a path is correct, say so in the audit report.

## Input Files

The following files are provided as inputs. Extract them before beginning.

=============== FILE: inputs/AGENTS.md ===============
# Invoicing Service — Agent Guide

## Quick Start

Boot the service:
```bash
./scripts/bootstrap.sh
```

Run tests:
```bash
npm test
```

Run integration tests:
```bash
npm run test:integration
```

## Key Conventions

- Use `src/utils/logger.ts` for all logging
- All invoice calculations go through `src/lib/calculator.ts`
- Config is loaded from `config/app.yaml` — never hardcode values
- Database migrations: `npx knex migrate:latest`

## Docs

- Architecture: [docs/architecture.md](docs/architecture.md)
- API reference: [docs/api-v2.md](docs/api-v2.md)
- Deployment: [docs/ops/deploy.md](docs/ops/deploy.md)
- Runbook: [docs/ops/runbook.md](docs/ops/runbook.md)

=============== FILE: inputs/README.md ===============
# invoicing-service

REST API for invoice generation and payment tracking.

## Install

```bash
npm install
cp config/app.yaml.example config/app.yaml
```

## Quick Start

```bash
./scripts/bootstrap.sh
npm run dev
```

## Docs

- [Architecture](docs/architecture.md)
- [API Reference](docs/api-v2.md)
- [Deployment](docs/ops/deploy.md)
- [Runbook](docs/ops/runbook.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

=============== FILE: inputs/docs/ops/runbook.md ===============
# Invoicing Service — On-Call Runbook

## Common Issues

### Invoice generation failing

Check the service logs:
```bash
docker logs invoicing-service --tail 100
```

Verify the calculator is healthy by calling the health endpoint:
```bash
curl http://localhost:3000/api/v2/health
```

### PDF export broken

The invoice PDF export feature uses wkhtmltopdf. If PDFs aren't generating:

1. Check that wkhtmltopdf is installed: `which wkhtmltopdf`
2. Test directly: `./scripts/test-pdf.sh`
3. Check logs: `cat logs/pdf-errors.log`

If the feature is completely broken, you can disable it temporarily by setting `DISABLE_PDF_EXPORT=true` in the environment.

### Payment webhook failures

Webhook processing is handled by `src/api/webhooks.ts`. Common causes:

1. Signature mismatch — check `STRIPE_WEBHOOK_SECRET` in environment
2. Endpoint unreachable — verify `/api/v2/webhooks/stripe` is accessible
3. Database write failure — check `DATABASE_URL` and run `npx knex migrate:latest`

=============== FILE: inputs/repo-manifest.json ===============
{
  "_comment": "This file represents the actual current state of the repository after refactoring.",
  "scripts": {
    "exists": ["setup.sh", "seed.sh", "migrate.sh"],
    "removed": ["bootstrap.sh", "test-pdf.sh"]
  },
  "config": {
    "exists": ["config/settings.yaml", "config/settings.yaml.example"],
    "removed": ["config/app.yaml", "config/app.yaml.example"]
  },
  "src": {
    "exists": [
      "src/utils/logger.ts",
      "src/lib/calculator.ts",
      "src/api/webhooks.ts",
      "src/api/invoices.ts",
      "src/api/payments.ts"
    ],
    "removed": []
  },
  "docs": {
    "exists": [
      "docs/architecture.md",
      "docs/api-v3.md",
      "docs/ops/deploy.md",
      "docs/ops/runbook.md"
    ],
    "removed": ["docs/api-v2.md"]
  },
  "api_endpoints": {
    "exists": ["/api/v3/health", "/api/v3/invoices", "/api/v3/payments", "/api/v3/webhooks/stripe"],
    "removed": ["/api/v2/health", "/api/v2/webhooks/stripe"]
  },
  "features": {
    "removed": ["PDF export — feature was cut from v3 scope"]
  }
}

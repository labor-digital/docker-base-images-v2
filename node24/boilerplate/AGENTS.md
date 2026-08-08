# AGENTS.md

## Project Context

- This repository is a Docker boilerplate for Node.js 24.
- This file applies to all AI agents, assistants, and coding tools working in this repository.
- These instructions apply to the whole repository unless a more specific `AGENTS.md` exists in a subdirectory.

---

## Security Rules

- Never read, output, summarize, copy, or use real secrets in responses.
- Never expose content from `.env`, `.env.*`, private key files, certificates, database dumps, backups, runtime data, or logs.
- `.env.example` is the only allowed source for environment variable names and example values.
- If a secret is required, use a placeholder (e.g., `YOUR_SECRET_HERE`) or ask the developer to provide the value manually outside the repository.
- Never commit real secrets to Git or write them into generated files.

---

## Files and Paths That Must Not Be Read or Modified

- `.env`
- `.env.*`
- `*.pem`
- `*.key`
- `*.crt`
- `*.p12`
- `*.pfx`
- `*.kdbx`
- `*.gpg`
- `*.asc`
- `docker/data/**`
- `.docker/data/**`
- `mysql/**`
- `postgres/**`
- `redis/**`
- `storage/**`
- `var/**`
- `tmp/**`
- `logs/**`
- `*.log`
- `*.sql`
- `*.sql.gz`
- `*.dump`
- `*.bak`
- `*.backup`
- `node_modules/**`
- `vendor/**`
- `dist/**`
- `build/**`
- `coverage/**`
- `.cache/**`

---

## Docker-Specific Rules

- Do not analyze local Docker volumes or database data.
- Do not include production data in images, Dockerfiles, or Compose files.
- Do not write secrets into `Dockerfile`, `docker-compose.yml`, `docker-compose.override.yml`, or build arguments.
- Use only placeholders or values from `.env.example` for configuration examples.
- When changing Docker-related files, check that `.dockerignore` still excludes sensitive and unnecessary files.

---

## Working Rules for AI Agents

- Before making changes, check whether the affected files are in sensitive areas.
- Keep generated changes small, focused, and easy to review.
- Do not perform unnecessary formatting or large refactorings.
- Do not update dependency, framework, or Docker versions unless explicitly requested.
- When unsure, use safe placeholder values.
- For security-related changes, briefly explain why the change is safe.

---

## Expected Behavior Checklist

- [ ] No secrets or sensitive values in any output or generated file
- [ ] Changes are minimal and scoped to the task
- [ ] `.env.example` used as the only reference for environment variables
- [ ] Docker files do not contain real credentials or production data
- [ ] `.dockerignore` covers sensitive paths after any Docker-related changes

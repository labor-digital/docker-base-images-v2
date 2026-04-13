# LABOR.digital – Junie Guidelines

## General

- This project is based on the **LABOR.digital PHP 8.5 boilerplate** using our Docker base images.
- All application code lives in `src/`, all infrastructure scripts in `opt/`, and all end-to-end tests in `tests/`.
- The repository must remain **stateless**: never commit generated files, uploaded user data, logs, or temporary files.
- Always commit `composer.lock` and `yarn.lock` / `package-lock.json` — they are required for reproducible deployments.
- Line endings are **LF** for all text files (enforced via `.gitattributes`).
- Never commit `.env` or `.env.app` — only their `.template` counterparts belong in the repository.

---

## Coding Standards

### PHP

- Follow **PSR-12** coding style strictly.
- Use **strict types** (`declare(strict_types=1);`) in every PHP file.
- Class names use `PascalCase`, methods and variables use `camelCase`, constants use `UPPER_SNAKE_CASE`.
- Keep classes focused and small — prefer composition over inheritance.
- All public methods and classes must have **DocBlocks** with `@param` and `@return` annotations.
- Avoid raw SQL — use an ORM or query builder layer.
- Never suppress errors with `@` — handle them explicitly.

### JavaScript / Node

- Follow the project's ESLint configuration if present; otherwise default to **Airbnb style**.
- Use `const` by default, `let` only when reassignment is necessary; never use `var`.
- Prefer `async/await` over raw Promise chains.

### General

- No dead code, commented-out code blocks, or `TODO` comments should be merged into `main`/`master`.
- Keep functions short and single-purpose.
- Write self-documenting code; add comments only when the *why* is not obvious from the code itself.

---

## Docker & Infrastructure

- Do not modify the base image `Dockerfile` for application-level dependencies — use `opt/build.sh` instead.
- Scripts in `opt/` must be **idempotent** — they may run multiple times during a single boot sequence.
- Use `ensure_dir` and `ensure_perms` bash helpers (provided by the base image) instead of raw `mkdir` / `chmod` calls.
- Environment variables for infrastructure go into `.env` / `.env.template`; app secrets go into `.env.app` / `.env.app.template`.
- All secrets (dev, test, stage, and production) are managed via **Doppler** — never hard-code secrets anywhere in the codebase.
- Use **lab-cli** to manage the local development environment (Doppler token registration, `.env` file generation, starting Docker Compose, etc.) — do not invoke `docker compose` directly. See [lab-cli](https://github.com/labor-digital/lab-cli).

---

## Git Workflow

### Branches

| Branch pattern | Purpose |
|---|---|
| `main` / `master` | Integration branch for completed features. Protected — no direct pushes. |
| `production` | Code running on production. Only updated via PR from `main`/`master` — pipeline will FF-merge automatically. |
| `feature/<short-description>` | New features or enhancements. Derived from `main`/`master`, merged back via PR (Squash & Merge). |
| `hotfix/<short-description>` | Critical production fixes. Derived from `production`, merged back to `production` via PR (FF-merge). A corresponding `bugfix/*` branch is created automatically to bring the fix into `main`/`master`. |
| `bugfix/<short-description>` | Carries a hotfix into `main`/`master`. Only FF-merged into `main`/`master` via PR. |

- Branch names are **lowercase kebab-case** (e.g. `feature/user-authentication`).
- Always branch `feature/*` and `bugfix/*` off `main`/`master`; branch `hotfix/*` off `production`.
- Delete branches after they are merged.

### Commits

- Use **Conventional Commits** format:
  ```
  <type>(<scope>): <short summary>
  ```
  Common types: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`, `style`, `ci`.
- Summary line: **imperative mood**, max **72 characters**, no trailing period.
- Add a body when the *why* needs explanation; separate it from the summary with a blank line.
- Each commit should represent one logical change — avoid "WIP" or "misc fixes" commits on shared branches.
- Never force-push to `main`/`master` or `production`.

### Examples

```
feat(auth): add JWT refresh token endpoint

Implements silent token refresh to avoid unnecessary logouts
when the access token expires during an active session.
```

```
fix(mysql): handle connection timeout on slow startup
```

---

## Pull Requests

- Every change to `main`/`master` or `production` must go through a **Pull Request** — no direct pushes.
- PRs from `feature/*` into `main`/`master` are merged via **Squash & Merge**.
- PRs from `main`/`master` into `production` are **FF-merged automatically** by the pipeline.
- PRs from `hotfix/*` into `production` are **FF-merged automatically** by the pipeline.
- PRs from `bugfix/*` into `main`/`master` are **FF-merged** via PR.
- PR title follows the same Conventional Commits format as commit messages.
- Fill out the PR description:
  - **What** was changed and **why**.
  - Steps to test / verify the change locally.
  - Link to the related issue or ticket if applicable.
- A PR must have **at least one approving review** before merging.
- All CI checks (build, tests) must be **green** before merging.
- Resolve all review comments before requesting a re-review.
- Keep PRs small and focused — one feature or fix per PR.

---

## Testing

- End-to-end tests live in `tests/` and run via the `test` service defined in `docker-compose.yml` (Playwright).
- Tests are also executed automatically in **Bitbucket Pipelines** on every relevant branch.
- New features must be accompanied by at least a basic E2E test covering the happy path.
- Bug fixes must include a regression test that would have caught the bug.
- Tests must pass locally before opening a PR — use lab-cli to run the test service:
  ```bash
  lab test
  ```
- Test reports and results (`tests/test-reports/`, `tests/test-results/`) are git-ignored — never commit them.

---

## Changelog

- `CHANGELOG.md` is maintained **automatically** by Bitbucket Pipelines on every commit to `main`/`master` — do not edit it manually.
- Changelog entries are derived from Conventional Commits messages, so writing clear and accurate commit messages is essential.

# Repository Audit Guide — Engineering Constitution

This guide enables **any AI agent or human reviewer** to audit a repository for compliance with the [Engineering Constitution](../CONSTITUTION.md) and identify improvement opportunities.

## How to Use This Guide

1. Read the full [CONSTITUTION.md](../CONSTITUTION.md) and [extensions.md](extensions.md).
2. Work through each audit section below in order.
3. For every check, record: ✅ Pass, ⚠️ Partial, ❌ Fail, or N/A.
4. Produce an **Audit Report** using the template at the bottom of this file.
5. File findings as issues or a single summary PR.

---

## Audit Checklist

### 1. Repository Structure & Configuration

- [ ] `README.md` exists and clearly describes the project purpose, setup, and usage.
- [ ] `CONSTITUTION.md` is present (or agent instruction files reference the canonical URL).
- [ ] Agent instruction files exist: `CLAUDE.md`, `AGENTS.md`, `.github/copilot-instructions.md`, `.cursorrules`.
- [ ] `.github/PULL_REQUEST_TEMPLATE.md` exists and includes issue link, summary, test/validation plan, and checklist.
- [ ] `CHANGELOG.md` exists and follows [Keep a Changelog](https://keepachangelog.com/) format.
- [ ] `CONTRIBUTING.md` exists and references the Constitution.
- [ ] `docs/` directory exists if the project has extended documentation needs.
- [ ] `.env.example` exists if environment variables are used (never a real `.env`).

### 2. Branch Protection & Git Workflow

- [ ] `main` branch is protected (require PR, require approvals, require status checks, no force-push).
- [ ] `dev` branch is protected with the same rules.
- [ ] Branch naming follows convention: `feat/`, `fix/`, `release/`, `hotfix/`.
- [ ] Commit messages use imperative mood, reference issues, and are < 72 chars.
- [ ] Squash merge is the default merge strategy.
- [ ] Branches are deleted after merge.

### 3. CI/CD Pipeline

- [ ] `.github/workflows/ci.yml` exists and runs on push/PR to `main` and `dev`.
- [ ] CI includes linting and formatting checks.
- [ ] CI includes all tests (unit, integration, etc.).
- [ ] CI includes build/compile verification (for executable code repos).
- [ ] CI includes security/dependency scanning (Dependabot, Gitleaks, or equivalent).
- [ ] CI includes file-format validation for non-executable repos (Markdown lint, YAML/JSON validation, link checks).
- [ ] `.github/workflows/release.yml` exists and triggers on version tags.
- [ ] No CI steps are using placeholder `echo` commands instead of real checks.

### 4. Verification-First Development

**For executable code repositories:**

- [ ] Tests exist and cover meaningful behavior (not just trivial assertions).
- [ ] Test structure follows TDD evidence: tests define behavior before implementation.
- [ ] Test coverage meets minimum threshold (≥ 80% recommended).
- [ ] Tests are organized by type (unit, integration, e2e) where applicable.
- [ ] Language-appropriate test framework is used (pytest, JUnit, Vitest, etc.).

**For non-executable artifact/workflow/documentation repositories:**

- [ ] Validation checks exist (Markdown lint, JSON/YAML validation, link checks, schema checks).
- [ ] Required-file checks verify repository conventions.
- [ ] Secret scanning is enabled.
- [ ] Large-file or forbidden-file detection is in place.
- [ ] Manual validation steps are documented in PRs when automation is not practical.

### 5. Code Quality & Design

- [ ] Linter is configured and enforced in CI (no warnings suppressed with `# noqa`, `@SuppressWarnings`, etc.).
- [ ] Formatter is configured and enforced in CI.
- [ ] Code follows SOLID principles where object-oriented design is used.
- [ ] No God Objects, circular dependencies, or excessive coupling observed.
- [ ] Functions are focused and reasonably short (target ≤ 30 lines, max 50).
- [ ] Files are reasonably short (target ≤ 300 lines, max 500).
- [ ] Naming is semantic and descriptive, following language conventions.
- [ ] Nesting depth does not exceed 3 levels without extraction.
- [ ] Public APIs, classes, and modules have docstrings/documentation.
- [ ] Comments explain *why*, not *what* (code is self-documenting).

### 6. Security

- [ ] No secrets, credentials, API keys, or tokens in code or git history.
- [ ] No `.env` files committed (only `.env.example`).
- [ ] Dependabot or equivalent dependency scanning is enabled.
- [ ] Secret scanning is enabled on the repository.
- [ ] No large model files, generated output batches, private images, or machine-specific artifacts committed.
- [ ] Input validation exists at system boundaries (controllers, handlers, API endpoints).
- [ ] No SQL/command injection vulnerabilities in user-facing code.
- [ ] Authentication uses industry-standard patterns (OAuth2, OIDC, bcrypt/Argon2 for passwords).
- [ ] Authorization follows principle of least privilege.

### 7. Error Handling & Logging

- [ ] Errors are handled explicitly (no silent catches, no bare `except:` / `catch(Exception)`).
- [ ] Domain-specific exception types exist where applicable.
- [ ] API errors use structured responses (consistent error envelope format).
- [ ] Logging uses structured format (JSON preferred for services).
- [ ] Log levels are used semantically (DEBUG, INFO, WARN, ERROR).
- [ ] No secrets, tokens, passwords, or PII are logged.
- [ ] Requests carry correlation/trace IDs for observability.

### 8. Documentation Quality

- [ ] README covers: purpose, prerequisites, setup, usage, testing, and deployment.
- [ ] Architecture or design decisions are documented (ADRs or equivalent).
- [ ] API documentation exists for HTTP services (OpenAPI/Swagger or equivalent).
- [ ] Runbooks exist for production services (startup, shutdown, troubleshooting).
- [ ] CHANGELOG is current and documents recent changes.

### 9. Technology-Specific Checks

**Python:**

- [ ] Ruff is used for linting and formatting.
- [ ] pyright is used in strict mode for type checking.
- [ ] pytest + pytest-cov with `--cov-fail-under=80`.
- [ ] Dependencies pinned via `uv` or `pip-compile`.
- [ ] Docker multi-stage builds for containerized deployments.
- [ ] Provider/adapter pattern for external service integrations.

**Android / Kotlin:**

- [ ] Jetpack Compose + Material 3 for UI.
- [ ] Hilt for dependency injection.
- [ ] Spotless + ktlint for formatting; Detekt for static analysis.
- [ ] MVVM + Clean Architecture (presentation/domain/data layers).
- [ ] All Detekt default rules enabled.

**TypeScript / Node.js:**

- [ ] Biome (preferred) or ESLint + Prettier for linting/formatting.
- [ ] `strict: true` in `tsconfig.json`.
- [ ] Vitest (preferred) or Jest for testing.
- [ ] pnpm for package management.

**Java:**

- [ ] Checkstyle or Google Java Format for formatting.
- [ ] SpotBugs or Error Prone for static analysis.
- [ ] JUnit 5 + JaCoCo with coverage threshold ≥ 80%.
- [ ] Maven or Gradle with dependency locking.
- [ ] No `@SuppressWarnings` without team-approved PR justification.

### 10. Agent Instruction File Quality

- [ ] Agent files reference the canonical Constitution URL.
- [ ] Immutable Rules match the current Constitution version.
- [ ] Verification protocol covers both TDD and VDD paths.
- [ ] SOLID principles are mentioned for software repos.
- [ ] Prohibited actions list is complete and current.
- [ ] Agent files are not stale (check against latest Constitution version).

---

## Audit Severity Ratings

Use these ratings when reporting findings:

| Rating | Meaning | Action Required |
|--------|---------|-----------------|
| 🔴 **CRITICAL** | Immutable Rule violation or security vulnerability | Must fix before next merge |
| 🟠 **HIGH** | Important standard missing or significantly incomplete | Fix within current sprint/cycle |
| 🟡 **MEDIUM** | Best practice gap that weakens quality | Plan for near-term improvement |
| 🔵 **LOW** | Optional improvement or minor inconsistency | Track in backlog |

---

## Audit Report Template

When completing an audit, produce a report in this format:

```markdown
# Audit Report: [Repository Name]

**Auditor**: [Agent name or human name]
**Date**: YYYY-MM-DD
**Constitution Version**: X.Y
**Repository**: [org/repo-name]
**Repository Type**: [Executable Software | Artifact/Workflow/Documentation]

## Summary

| Category | Pass | Partial | Fail | N/A |
|----------|------|---------|------|-----|
| Repo Structure | X | X | X | X |
| Branch Protection | X | X | X | X |
| CI/CD Pipeline | X | X | X | X |
| Verification-First | X | X | X | X |
| Code Quality | X | X | X | X |
| Security | X | X | X | X |
| Error Handling & Logging | X | X | X | X |
| Documentation | X | X | X | X |
| Technology-Specific | X | X | X | X |
| Agent Instructions | X | X | X | X |

## Critical Findings

1. [Finding] — Severity: 🔴 CRITICAL
   - **What**: Description of the issue
   - **Where**: File path or configuration
   - **Fix**: Recommended remediation

## High Priority Findings

1. [Finding] — Severity: 🟠 HIGH
   ...

## Medium Priority Findings

1. [Finding] — Severity: 🟡 MEDIUM
   ...

## Low Priority Findings

1. [Finding] — Severity: 🔵 LOW
   ...

## Recommendations

Ordered list of recommended next steps.
```

---

## Running an Audit as an AI Agent

If you are an AI agent asked to audit a repository:

1. **Read this entire guide** before starting.
2. **Read the repository's `CONSTITUTION.md`** (or the canonical URL if not present locally).
3. **Examine every file and directory** in the repository systematically.
4. **Check CI configuration** — look at `.github/workflows/` and verify real checks run.
5. **Check branch protection** — verify `main` and `dev` are protected (via GitHub API or Settings).
6. **Sample the codebase** — read representative source files, tests, and configs to assess quality.
7. **Produce the Audit Report** using the template above.
8. **Be specific** — cite file paths, line numbers, and exact issues. Do not give vague assessments.
9. **Be constructive** — every finding must include a concrete remediation recommendation.
10. **Do NOT make changes** during an audit. Report findings only. Changes come after human review.

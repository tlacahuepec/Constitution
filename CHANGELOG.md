# Changelog

All notable changes to the Engineering Constitution will be documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/).

## [2.1.0] - 2026-09-20

### Added

- **Section 0 — Adoption Guide: Classify Your Project**: New tiered adoption model with 4 project tiers (Prototype/Experiment → Personal Tool → Internal/Team → Production/Public). Projects classify themselves via a questionnaire and follow a compliance matrix that scales standards by tier.
- **Compliance Matrix**: 12 flexible standards scaled by tier (Required ✅ / Recommended 💡 / Optional —) including GitFlow, SemVer, PR approval, environment tiers, deployment strategies, rollback triggers, docstrings, input validation, observability, OpenAPI, post-mortems, and accessibility. 35 standards remain always required at every tier (including TDD).
- **Step 5 — Onboarding Plan**: Mandatory audit-and-backlog workflow when adopting the Constitution, including a removal story for explicitly documenting excluded higher-tier standards.
- **Step 6 — Track Compliance Progress**: Tier 1/2 projects track compliance via a local `COMPLIANCE.md` file; Tier 3/4 projects use GitHub Issues with a `constitution` label and a milestone as their compliance dashboard.
- **Tier Declaration Requirement**: Repositories must declare their Constitution tier in `README.md`.
- **Immutable Rule 5 — No force-pushes on any branch**: Strengthened from protected-only to all branches. History is immutable once pushed.
- **Immutable Rule 6 — No history rewrites after push**: Explicitly bans `git commit --amend`, `git rebase`, and any other history rewrite after pushing to a remote.
- **Codebase & Directory Structure Standards**: Added mandatory standards in Section 5 covering Package by Feature (Screaming Architecture), Clean Architecture layering, stack-aware test placement (colocation vs mirror tree), folder depth limits (≤ 4), ban on `utils/` junk drawers, and consistent casing per language stack.
- **Refactoring & Code Evolution Standards**: Added mandatory standards in Section 5 covering Pure Refactoring PRs, harmonized Boy Scout Rule (local hygiene vs structural PR separation), characterization tests before refactoring, Rule of Three with local readability precedence, Strangler Fig pattern for legacy migrations, Expand-Contract pattern for breaking interfaces, immediate dead code elimination, and feature flags for architectural shifts.
- **Self-Compliance**: Constitution repository declares itself as 🔧 Tier 2 — Personal Tool in `README.md`.

## [2.0.0] - 2026-09-20

### Added

- **SOLID Principles & Clean Code Design**: Operational rules for SRP (class size ≤ 300 lines), OCP, LSP, ISP, and DIP in Section 5.
- **Code Readability & Complexity Limits**: Non-negotiable limits on function length (≤ 30 lines), file length (≤ 300 lines), cyclomatic complexity (≤ 10), and nesting depth (≤ 3) in Section 5.
- **The Test Pyramid & Mocking Boundaries**: Codified Unit (70–80%), Integration (15–20%), and E2E (5–10%) layers with Arrange-Act-Assert structure. Absolute ban on mocking internal domain logic.
- **Technical Debt Policy**: Mandatory issue tracking for all `TODO(#123)` and `FIXME(#123)` comments with dedicated capacity allocation.
- **Input Validation & System Boundaries**: Mandatory schema validation (Pydantic, Zod, Jakarta) at system gateways in Section 6.
- **Structured Logging & Error Handling**: JSON structured logs, semantic levels, request correlation IDs (`X-Correlation-ID`), and RFC 7807 error envelopes in Section 7.
- **OWASP Top 10 Security Annex**: Comprehensive engineering mitigations guide in `docs/security.md`.
- **Data Privacy & PII Handling**: 4-tier data classification, field-level encryption (AES-256-GCM), and test data masking in lower environments.
- **Monitoring & Observability Standards**: Dual health endpoints (`/healthz` vs `/readyz`), Four Golden Signals, Prometheus format, and OpenTelemetry in `docs/observability.md`.
- **Accessibility (a11y) Standards**: WCAG 2.1 Level AA compliance, contrast ratios, and automated CI checks in `docs/extensions.md`.
- **API Design & Database Migration Policy**: RESTful design conventions, cursor pagination, and zero-downtime expand-and-contract migrations in `docs/extensions.md`.
- **Code Review Guide & Rubric**: Turnaround SLA, blocking vs non-blocking classifications (`nit:`), and 5-dimension review rubric in `docs/code-review.md`.
- **Semantic Versioning Policy**: Codified SemVer 2.0.0 and deprecation windows in Section 2.
- **Deployment Strategies & Environment Tiers**: Blue/Green and Canary rollouts with automated rollback triggers in Section 4.
- **Complete Templates Library in `templates/`**:
  - `SPEC_TEMPLATE.md` (SDD feature specification)
  - `ADR_TEMPLATE.md` (Architecture Decision Records)
  - `AUDIT_REPORT_TEMPLATE.md` (Paired with `docs/audit-guide.md`)
  - `CODE_REVIEW_CHECKLIST.md` (PR review rubric)
  - `SECURITY.md` (Vulnerability disclosure policy)
  - `POST_MORTEM_TEMPLATE.md` (Blameless incident retrospective)
  - `PULL_REQUEST_TEMPLATE.md` (Dual-path PR template)
  - Starter CI workflows in `templates/workflows/` (`python-ci.yml`, `java-ci.yml`, `typescript-ci.yml`, `vdd-ci.yml`).
- **Repository Audit Guide**: 10 categories, 80+ check audit engine in `docs/audit-guide.md`.
- **Modular Adoption Script**: Upgraded `scripts/adopt.sh` supporting `--agents`, `--templates`, `--all`, and `--workflow <type>`.
- **Java / JVM Technology Extension**: Added Google Java Format, SpotBugs, JUnit 5 + JaCoCo (≥ 80% coverage) to `docs/extensions.md`.

### Changed

- Upgraded PR template and `CONTRIBUTING.md` to dual-path Verification-First Development (TDD/VDD).
- Added Gitleaks secret scanning to repo CI workflow.
- Synchronized all AI agent templates (`CLAUDE.md`, `AGENTS.md`, Copilot, Cursor).

## [1.3] - 2026-06-06

### Added

- Verification-First Development (VFD) for all repository types.
- Validation-Driven Development (VDD) for artifact, workflow, template, prompt, configuration, and documentation repositories.
- Artifact / Workflow / Documentation repository guidance in `docs/extensions.md`.
- ComfyUI workflow repository standards for reusable local workflow libraries.

### Changed

- TDD remains required for executable production code.
- Non-executable repositories may use validation checks instead of irrelevant unit tests.
- Pull requests may include either a test plan or a validation plan.
- Agent templates now instruct agents to apply the correct verification method for the repository type.

## [1.2] - 2026-05-29

### Added

- Specification-Driven Development (SDD) definition in Section 1
- Expanded Rules for Agents (Section 9) with full protocol
- Agent instruction templates (`templates/` directory) for Claude Code, Codex, Copilot, and Cursor
- `docs/extensions.md` with language-specific standards (Python, Android/Kotlin, TypeScript)
- `scripts/adopt.sh` for automated setup of agent files in child repos
- Real CI workflows (markdown linting, link checking, YAML validation)
- Release workflow triggered on tags
- This CHANGELOG

### Changed

- Section 10 (Enforcement) now requires agent instruction files in every repo
- CI workflow replaced placeholder echo commands with real checks
- README updated with adoption instructions

## [1.1] - 2026-05-28

### Added

- Branch protection setup guide (Section 11)
- Linked issue requirement in PR template

## [1.0] - 2026-05-27

### Added

- Initial Engineering Constitution
- CI workflow template
- PR template
- Contributing guide

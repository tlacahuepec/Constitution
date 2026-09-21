# Constitution Expansion Backlog

Track progress one story at a time. Mark status as: `TODO`, `IN PROGRESS`, `DONE`.

---

## Phase 1: Harmonization & Fixes (v1.3.1)

| # | Story | Status | Notes |
|---|-------|--------|-------|
| 1 | Fix `CONTRIBUTING.md` — add VDD support, align with v1.3 | DONE | VFD & SDD added, TDD/VDD dual-path |
| 2 | Fix `.github/PULL_REQUEST_TEMPLATE.md` — support VDD path | DONE | Dual-path TDD/VDD, SOLID, no suppressions |
| 3 | Align `templates/AGENTS.md` — add SOLID mention | DONE | Added Always section with SOLID & tests/validation |
| 4 | Add Gitleaks to `ci.yml` | DONE | Added scan-secrets job with gitleaks-action |
| 5 | Expand `adopt.sh` — modular installation (--agents, --templates, --all) | DONE | Added flags and templates installation |

---

## Phase 2: SOLID, Readability & Templates Suite (v1.4)

| # | Story | Status | Notes |
|---|-------|--------|-------|
| 6 | Add SOLID Principles & Code Design section to `CONSTITUTION.md` | DONE | Operational rules for SRP, OCP, LSP, ISP, DIP |
| 7 | Add Code Readability & Complexity Limits section | DONE | Lengths (≤30/≤300), complexity ≤10, nesting ≤3 |
| 8 | Add SDD Feature Spec Template (`templates/SPEC_TEMPLATE.md`) | DONE | Full design doc with acceptance criteria |
| 9 | Add ADR framework (`templates/ADR_TEMPLATE.md` + Section 7) | DONE | ADR template and CONSTITUTION mandate |
| 10 | Add Audit Report Template (`templates/AUDIT_REPORT_TEMPLATE.md`) | DONE | Paired with `docs/audit-guide.md` |
| 11 | Add Code Review Checklist (`templates/CODE_REVIEW_CHECKLIST.md`) | DONE | Reviewer rubric for SOLID, readability, tests |
| 12 | Add Security Policy Template (`templates/SECURITY.md`) | DONE | Vulnerability reporting and SLAs |
| 13 | Add Child PR Template (`templates/PULL_REQUEST_TEMPLATE.md`) | DONE | Ready-to-copy dual-path PR template |
| 14 | Add Technical Debt Management policy | DONE | Mandatory TODO(#123) issue references |
| 15 | Add Input Validation & Sanitization standard | DONE | Boundary validation, pre-validated domain models |
| 16 | Add Structured Logging standard | DONE | JSON format, semantic levels, correlation IDs, PII redaction |
| 17 | Add OWASP Top 10 Security Annex | DONE | Dedicated guide in `docs/security.md` |
| 18 | Add Starter CI/CD Workflows (`templates/workflows/`) | DONE | Python, Java, TypeScript, and VDD workflows |

---

## Phase 3: Core Engineering Standards (v1.5)

| # | Story | Status | Notes |
|---|-------|--------|-------|
| 19 | Define Test Pyramid — unit/integration/e2e layers | DONE | 70-80% unit, 15-20% int, 5-10% e2e; AAA pattern |
| 20 | Add Code Review Rubric — `docs/code-review.md` | DONE | Reviewer duties, blocking vs non-blocking, SLA |
| 21 | Add API Design Standards | DONE | REST conventions, status codes, cursor pagination |
| 22 | Add Database & Migration Policy | DONE | Versioned migrations, expand-and-contract, indexes |
| 23 | Add Code Documentation Standards | DONE | Public docstrings (Javadoc, Google, TSDoc) |
| 24 | Formalize SemVer Versioning Policy | DONE | SemVer 2.0.0 and deprecation windows in Section 2 |

---

## Phase 4: Observability, Accessibility & Operations (v2.0)

| # | Story | Status | Notes |
|---|-------|--------|-------|
| 25 | Add Monitoring & Observability standard | DONE | `/healthz`, `/readyz`, Golden Signals in `docs/observability.md` |
| 26 | Add Accessibility (a11y) standards | DONE | WCAG 2.1 AA, contrast, keyboard in `docs/extensions.md` |
| 27 | Add Auth & Authorization patterns | DONE | OAuth2, OIDC, RBAC, Least Privilege in `docs/security.md` |
| 28 | Add Data Privacy & PII Handling policy | DONE | Classification, encryption at rest, data masking in `docs/security.md` |
| 29 | Add API Documentation requirement (OpenAPI) | DONE | OpenAPI 3.x CI validation mandate in Section 7 |
| 30 | Add Incident Management & Post-Mortem framework | DONE | `templates/POST_MORTEM_TEMPLATE.md` + 5-day policy |
| 31 | Add Deployment Strategies & Environment Management | DONE | Blue/Green, Canary, automated rollbacks in Section 4 |

---

## Phase 5: Tiered Adoption, Folder Org & Refactoring (v2.1)

| # | Story | Status | Notes |
|---|-------|--------|-------|
| 32 | Add Section 0 Tiered Adoption Guide & Classification Questionnaire | DONE | 4-tier model (T1-T4), 12 flexible / 35 required matrix |
| 33 | Add Onboarding Plan (Step 5) & Compliance Tracker (Step 6) | DONE | Audit-and-backlog workflow, local COMPLIANCE.md |
| 34 | Add Codebase & Directory Structure Standards | DONE | Package by feature, Clean Arch, test colocation, depth ≤ 4 |
| 35 | Add Refactoring & Code Evolution Standards | DONE | Pure PRs, Boy Scout hygiene, Strangler Fig, Rule of Three |

---

## Phase 6: Public Repo Guard & Tooling (v2.2)

| # | Story | Status | Notes |
|---|-------|--------|-------|
| 36 | Add Public Repo Protection & Tamper Defense Guide | DONE | Fork PR threat models and GitHub settings in `docs/security.md` |
| 37 | Add Repo Guard Workflow (`templates/workflows/repo-guard.yml`) | DONE | Auto-detect fork PRs, block workflow edits, alert owner |
| 38 | Add Turnkey Compliance Template (`templates/COMPLIANCE_TEMPLATE.md`) | DONE | Full checklist and removal story documentation |
| 39 | Expand `scripts/adopt.sh` with `--tier` and `--guard` flags | DONE | CLI support for tier setup and Repo Guard installation |

---

## Phase 7: Branch Freshness & Lineage Protocol (v2.3)

| # | Story | Status | Notes |
|---|-------|--------|-------|
| 40 | Formalize Branch Freshness & Lineage Protocol in Section 2 | DONE | Pre-branch sync (`git fetch origin`), continuous merge |
| 41 | Synchronize Agent Instruction Templates | DONE | Step-by-step sync commands in AGENTS, CLAUDE, Copilot, Cursor |

---

## Phase 8: Repository Self-Onboarding (v2.3.1)

| # | Story | Status | Notes |
|---|-------|--------|-------|
| 42 | Adopt Constitution v2.3 in `Constitution` repo via `adopt.sh` | DONE | Installed agent suite, security policy, and templates |
| 43 | Conduct maintainer classification interview | DONE | Documented in `COMPLIANCE.md` designating Tier 2 |
| 44 | Add cross-platform `.gitattributes` & `.yamllint.yml` | DONE | Enforce LF line endings and workflow formatting |

---

## Phase 9: Tier 2 Excluded Standards (Removal Stories)

Per Constitution Section 0 Step 5, these stories explicitly document and audit why higher-tier standards are excluded for this repository:

| Story | Excluded Standard | Rationale / Exemption Justification | Status |
|-------|-------------------|-------------------------------------|:------:|
| **R-1** | **Test Pyramid Ratios (70/20/10)** | Excluded: `Constitution` is a non-executable governance and documentation repo. Verification is strictly governed by **VDD (Validation-Driven Development)** using markdownlint, lychee link checker, YAML validation, and bash syntax checks. | **EXCLUDED** |
| **R-2** | **Multi-Tier Environments (dev/staging/prod) & Zero-Downtime Deployments** | Excluded: No compiled binaries or running web servers. Releases are delivered directly via GitHub Releases and Git tags. | **EXCLUDED** |
| **R-3** | **Observability Endpoints (`/healthz`, `/readyz`, Four Golden Signals)** | Excluded: Static documentation and shell scripts only; no persistent daemon or HTTP process. | **EXCLUDED** |
| **R-4** | **OpenAPI 3.x Specifications** | Excluded: Repository does not expose HTTP REST endpoints. | **EXCLUDED** |
| **R-5** | **Incident Management & Post-Mortems** | Excluded: No production services or external SLAs. | **EXCLUDED** |
| **R-6** | **Accessibility (WCAG 2.1 AA)** | Excluded: No custom front-end UI or web application code. | **EXCLUDED** |

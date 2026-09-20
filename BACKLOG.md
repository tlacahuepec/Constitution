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

## Completed

- **Story 1**: Fix `CONTRIBUTING.md` — added VDD & SDD support, aligned with Constitution v1.3.
- **Story 2**: Fix `.github/PULL_REQUEST_TEMPLATE.md` — added dual-path TDD/VDD verification, SOLID check, zero suppressions check, forbidden files check.
- **Story 3**: Align `templates/AGENTS.md` — added Always section with SOLID principles and test/validation mandates.
- **Story 4**: Add Gitleaks secret scanning job to `.github/workflows/ci.yml`.
- **Story 5**: Expand `scripts/adopt.sh` — added modular `--agents`, `--templates`, and `--all` options.
- **Story 6**: Add SOLID Principles & Code Design standards to `CONSTITUTION.md`.
- **Story 7**: Add Code Readability & Complexity Limits (≤30 lines/function, ≤300 lines/file, complexity ≤10, nesting ≤3) to `CONSTITUTION.md`.
- **Story 8**: Add SDD Feature Specification Template (`templates/SPEC_TEMPLATE.md`).
- **Story 9**: Add ADR Template (`templates/ADR_TEMPLATE.md`) and mandate in `CONSTITUTION.md` Section 7.
- **Story 10**: Add Standalone Audit Report Template (`templates/AUDIT_REPORT_TEMPLATE.md`).
- **Story 11**: Add Code Review Checklist (`templates/CODE_REVIEW_CHECKLIST.md`).
- **Story 12**: Add Security Policy Template (`templates/SECURITY.md`).
- **Story 13**: Add Child PR Template (`templates/PULL_REQUEST_TEMPLATE.md`).
- **Story 14**: Add Technical Debt Management policy (`TODO(#issue)` mandate).
- **Story 15**: Add Input Validation & System Boundaries standard.
- **Story 16**: Add Structured JSON Logging, Correlation IDs, and Error Handling standards.
- **Story 17**: Add OWASP Top 10 Security Annex (`docs/security.md`).
- **Story 18**: Add Starter CI/CD Workflows (`templates/workflows/` for Python, Java, TypeScript, and VDD) and updated `adopt.sh` with `--workflow`.
- **Story 19**: Define Test Pyramid (unit/integration/e2e layers, AAA pattern, mocking boundaries) in `CONSTITUTION.md`.
- **Story 20**: Add Code Review Rubric & Guide (`docs/code-review.md`).
- **Story 21**: Add API Design Standards (REST conventions, status codes, cursor pagination) in `docs/extensions.md`.
- **Story 22**: Add Database & Migration Policy (versioned migrations, expand-and-contract pattern, indexes) in `docs/extensions.md`.
- **Story 23**: Add Code Documentation Standards in `CONSTITUTION.md`.
- **Story 24**: Formalize SemVer 2.0.0 and Deprecation Policy in `CONSTITUTION.md` Section 2.
- **Story 25**: Add Monitoring & Observability standards (`docs/observability.md`).
- **Story 26**: Add Accessibility (a11y) standards (WCAG 2.1 AA) in `docs/extensions.md`.
- **Story 27**: Add Authentication & Authorization standards (OAuth2, OIDC, RBAC) in `docs/security.md`.
- **Story 28**: Add Data Privacy & PII Handling policy (classification, encryption, masking) in `docs/security.md`.
- **Story 29**: Add OpenAPI 3.x CI validation mandate in `CONSTITUTION.md`.
- **Story 30**: Add Incident Management & Blameless Post-Mortem framework (`templates/POST_MORTEM_TEMPLATE.md`).
- **Story 31**: Add Deployment Strategies (Blue/Green, Canary) & Environment Management in `CONSTITUTION.md`.

---

🎉 **ALL 31 EXPANSION STORIES COMPLETED — CONSTITUTION VERSION 2.0 RELEASED!**

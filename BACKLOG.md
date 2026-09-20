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
| 19 | Define Test Pyramid — unit/integration/e2e layers | TODO | Coverage thresholds, mocking rules, test naming |
| 20 | Add Code Review Rubric — `docs/code-review.md` | TODO | Reviewer duties, blocking vs non-blocking, SLA |
| 21 | Add API Design Standards | TODO | REST conventions, error envelopes (RFC 7807), versioning |
| 22 | Add Database & Migration Policy | TODO | Versioned migrations, indexing, transaction boundaries |
| 23 | Add Code Documentation Standards | TODO | Docstring formats, inline comment rules |
| 24 | Formalize SemVer Versioning Policy | TODO | MAJOR/MINOR/PATCH criteria, deprecation windows |

---

## Phase 4: Observability, Accessibility & Culture (v2.0)

| # | Story | Status | Notes |
|---|-------|--------|-------|
| 20 | Add Monitoring & Observability standard | TODO | Health endpoints, metrics, tracing |
| 21 | Add Accessibility (a11y) standards | TODO | WCAG 2.1 AA, axe-core, ARIA |
| 22 | Add Auth & Authorization patterns | TODO | OAuth2, RBAC, token storage, password hashing |
| 23 | Add Data Privacy & PII Handling policy | TODO | Classification, encryption, retention, GDPR |
| 24 | Add API Documentation requirement (OpenAPI) | TODO | Swagger/OpenAPI 3.x in CI |
| 25 | Add Incident Management & Post-Mortem framework | TODO | Severity levels, escalation, blameless retros |
| 26 | Add Deployment Strategies & Environment Management | TODO | Blue/green, canary, rollback, env tiers |

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

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
| 5 | Expand `adopt.sh` — optionally install PR template + markdownlint | TODO | Currently only copies 4 agent files |

---

## Phase 2: Critical Gaps (v1.4)

| # | Story | Status | Notes |
|---|-------|--------|-------|
| 6 | Add SOLID Principles & Code Design section to `CONSTITUTION.md` | TODO | Define all 5 principles with do/don't |
| 7 | Add Code Readability & Complexity Limits section | TODO | Naming, function length, file length, cyclomatic complexity |
| 8 | Add Technical Debt Management policy | TODO | TODO/FIXME conventions, debt tracking |
| 9 | Add ADR framework — template + `docs/adr/` convention | TODO | Architecture Decision Records |
| 10 | Add Input Validation & Sanitization standard | TODO | Schema validation at boundaries |
| 11 | Add Structured Logging standard | TODO | JSON format, log levels, PII redaction |
| 12 | Add OWASP Top 10 Security Annex | TODO | `docs/security.md` with mitigations |

---

## Phase 3: Core Engineering Standards (v1.5)

| # | Story | Status | Notes |
|---|-------|--------|-------|
| 13 | Define Test Pyramid — unit/integration/e2e layers | TODO | Coverage thresholds, mocking rules, test naming |
| 14 | Add Code Review Rubric — `docs/code-review.md` | TODO | Reviewer duties, blocking vs non-blocking, SLA |
| 15 | Add API Design Standards | TODO | REST conventions, error envelopes (RFC 7807), versioning |
| 16 | Add Database & Migration Policy | TODO | Versioned migrations, indexing, transaction boundaries |
| 17 | Add Error Handling Patterns section | TODO | Exception hierarchies, error boundaries, fail-fast |
| 18 | Add Code Documentation Standards | TODO | Docstring formats, inline comment rules |
| 19 | Formalize SemVer Versioning Policy | TODO | MAJOR/MINOR/PATCH criteria, deprecation windows |

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

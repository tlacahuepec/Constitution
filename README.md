# Engineering Constitution

This repository contains the official **Engineering Constitution (Version 2.1)** that governs **all** software and artifact development across every tlacahuepec repository.

## Constitution Compliance

**Project Tier**: 🔧 Tier 2 — Personal Tool  
**Constitution Version**: 2.1

> This repository is a non-executable artifact/documentation repo. It follows
> VDD (Validation-Driven Development) with markdownlint, link checks, and
> bash syntax validation as its verification methods.

It defines the non-negotiable standards for:

- Branching & Git workflow (GitFlow + SemVer 2.0.0)
- Verification-First Development (TDD for code, VDD for non-code artifacts)
- SOLID principles & code readability limits
- Security, OWASP Top 10 mitigations & Data Privacy (PII)
- Structured JSON logging, correlation IDs & error handling
- Monitoring, health endpoints & observability
- Code review rubrics & blameless post-mortems
- Automated CI/CD pipelines & zero-downtime deployment strategies

**This is the single source of truth.** Every repository (Python, Kotlin/Android, Java, TypeScript, Pascal, Assembly, or any other technology) must follow it.

## Quick Links

- [Full Constitution (v2.1)](./CONSTITUTION.md)
- [Technology Extensions](./docs/extensions.md)
- [Audit Guide](./docs/audit-guide.md)
- [Security Standards (OWASP Top 10)](./docs/security.md)
- [Monitoring & Observability Standards](./docs/observability.md)
- [Code Review Guide](./docs/code-review.md)
- [Contributing Guide](./CONTRIBUTING.md)
- [Changelog](./CHANGELOG.md)

---

## Adopting the Constitution in Your Repository

### Automatic Setup

Run the adoption script to install agent instruction files, repository templates, and starter CI workflows into any repo:

```bash
git clone https://github.com/tlacahuepec/Constitution.git /tmp/constitution
# Install all templates with specified tier and CI workflow
/tmp/constitution/scripts/adopt.sh --all --tier 2 --workflow python /path/to/your/repo

# Install public repository tamper defense (alerts on external fork PRs)
/tmp/constitution/scripts/adopt.sh --guard /path/to/your/repo

# Or install only agent instructions
/tmp/constitution/scripts/adopt.sh --agents /path/to/your/repo

# Or install only repository templates (PR, Spec, ADR, Checklist, Security, Compliance)
/tmp/constitution/scripts/adopt.sh --templates --tier 2 /path/to/your/repo
```

This installs:

| File | Type / Platform |
|------|-----------------|
| `CLAUDE.md` | Claude Code agent instructions |
| `AGENTS.md` | OpenAI Codex agent instructions |
| `.github/copilot-instructions.md` | GitHub Copilot instructions |
| `.cursorrules` | Cursor rules |
| `.github/PULL_REQUEST_TEMPLATE.md` | Dual-path PR template (TDD / VDD) |
| `docs/templates/SPEC_TEMPLATE.md` | Specification-Driven Development (SDD) spec template |
| `docs/adr/ADR_TEMPLATE.md` | Architecture Decision Record template |
| `docs/CODE_REVIEW_CHECKLIST.md` | Code review rubric (SOLID, readability, quality) |
| `SECURITY.md` | Vulnerability reporting and security policy |
| `COMPLIANCE.md` | Constitution compliance tracker (Tier 1 & 2) |
| `.github/workflows/repo-guard.yml` | Tamper defense & alert workflow for public repos (`--guard`) |

### Manual Setup

1. Copy agent files from `templates/` (`CLAUDE.md`, `AGENTS.md`, `.github/copilot-instructions.md`, `.cursorrules`).
2. Copy `templates/PULL_REQUEST_TEMPLATE.md` → your repo as `.github/PULL_REQUEST_TEMPLATE.md`.
3. Copy `templates/SPEC_TEMPLATE.md` → your repo as `docs/templates/SPEC_TEMPLATE.md`.
4. Copy `templates/ADR_TEMPLATE.md` → your repo as `docs/adr/ADR_TEMPLATE.md`.
5. Copy `templates/CODE_REVIEW_CHECKLIST.md` → your repo as `docs/CODE_REVIEW_CHECKLIST.md`.
6. Copy `templates/SECURITY.md` → your repo root as `SECURITY.md`.
7. (Optional) Copy `CONSTITUTION.md` to your repo root for offline agent access.
8. Configure branch protection per [Section 11](./CONSTITUTION.md#11-repository-setup--branch-protection-one-time-setup).

### Keeping Up to Date

Templates reference the canonical Constitution URL. Agents with network access fetch the latest version. For offline compliance, re-run the adoption script periodically or copy updated templates manually.

---

## For AI Agents

If you are an AI agent reading this repository: read [CONSTITUTION.md](./CONSTITUTION.md) in full before contributing. All rules are mandatory and enforced via CI and branch protection.

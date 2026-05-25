# Engineering Constitution

**Version 1.0** — May 2026  
**Author**: tlacahuepec  
**Applies to**: All repositories under tlacahuepec (any language or platform)

## 1. Preamble & Core Principles

We build **robust, secure, maintainable, and high-quality software** using:

- **Test-Driven Development (TDD)** as mandatory practice
- **Specification-Driven Development (SDD)** — clear requirements before implementation
- Security and reliability by default (zero tolerance for vulnerabilities or leaked secrets)
- Cutting-edge technologies when they add clear value, while remaining technology-agnostic
- Consistency, automation, and documentation so humans **and agents** can contribute safely

**This Constitution is the single source of truth.** Every PR, commit, and CI run must comply.

### Immutable Rules (apply to every repo)
1. TDD is mandatory — write failing tests **before** production code.
2. Never push directly to `main` or `dev`.
3. Protected branches are sacred — all changes go through PRs + CI.
4. No secrets ever in the repository.
5. No force-pushes on protected branches.
6. One logical change per PR (one issue per branch).
7. CI must pass before any merge.

## 2. Version Control & Branching Strategy (GitFlow + Git Town)

```
main      ← Production / stable releases (protected)
dev       ← Integration branch (protected)
feat/*    ← New features
fix/*     ← Bug fixes
release/* ← Release candidates
hotfix/*  ← Urgent production fixes
```

**Branch naming convention**  
`feat/descriptive-name`, `fix/descriptive-name`, `release/v1.2.3`, `hotfix/security-xyz`

**Commit convention**  
`Add user authentication module (#42)`  
Imperative mood, reference issue, < 72 chars.

**Git Town** is strongly recommended for complex stacked-branch work.

## 3. Pull Request & Merging Rules

Every change requires a Pull Request.

**Required in every PR**:
- Link to issue/spec
- Summary of changes
- Test plan
- Checklist (see PR template)

**Merging rules** (enforced via branch protection):
- At least 1 approval
- All CI checks green
- Squash merge (clean history)
- Delete branch after merge

## 4. CI/CD Requirements (Mandatory)

Every repository **must** have `.github/workflows/ci.yml` that runs on:
- Pull requests
- Pushes to `dev`, `main`, `release/*`

**Minimum checks**:
- Linting + formatting
- All tests
- Build / compile
- Security / dependency scanning

Release workflow (on tags) must create GitHub Release + publish artifacts.

## 5. Testing & Quality Standards

- TDD mandatory
- Tests must exist and pass before merge
- Language-appropriate tools (pytest, JUnit, etc.)
- Formatting & linting **enforced** in CI (Ruff, Spotless, ktlint, Prettier, clang-format, etc.)

## 6. Security & Secrets

- Use `.env.example` + GitHub Secrets
- Enable Dependabot + secret scanning
- No secrets in code or history

## 7. Documentation

- Clear `README.md`
- This `CONSTITUTION.md`
- `docs/` folder when needed
- `CHANGELOG.md` or automated releases

## 8. Technology-Specific Extensions

(Expand as needed)

**Python**  
Ruff + pyright, Docker-first, provider pattern for external services.

**Android / Kotlin**  
Jetpack Compose + Material 3, Hilt, Room, Spotless + ktlint + Detekt (mandatory), Git Town.

**Any other language**  
Follow generic rules + add language-specific lint/test tools to CI.

## 9. Rules for Agents (AI Contributors)

Agents **must** read this file first, follow TDD, use correct branch/PR conventions, and never bypass CI.

## 10. Enforcement & Evolution

- Changes to this Constitution require a PR to **this** repository.
- Violations block merges.
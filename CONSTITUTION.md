# Engineering Constitution

**Version 1.2** — May 2026  
**Author**: tlacahuepec  
**Applies to**: All repositories under tlacahuepec (any language or platform)

## 1. Preamble & Core Principles

We build **robust, secure, maintainable, and high-quality software** using:

- **Test-Driven Development (TDD)** as mandatory practice
- **Specification-Driven Development (SDD)** — clear requirements before implementation (see below)
- Security and reliability by default (zero tolerance for vulnerabilities or leaked secrets)
- Cutting-edge technologies when they add clear value, while remaining technology-agnostic
- Consistency, automation, and documentation so humans **and agents** can contribute safely

**This Constitution is the single source of truth.** Every PR, commit, and CI run must comply.

### Specification-Driven Development (SDD)

Every feature, fix, or change begins with a **written spec** before any code is written:

1. Define the problem or requirement in an issue or design document.
2. Specify inputs, outputs, acceptance criteria, and edge cases.
3. Get the spec approved (via issue assignment or PR review of the spec).
4. Only then begin implementation — guided by the spec and validated by TDD.

SDD defines **what** to build; TDD defines **how to verify** it works.

### Immutable Rules (apply to every repo)

1. TDD is mandatory — write failing tests **before** production code.
2. Never push directly to `main` or `dev`.
3. Protected branches are sacred — all changes go through PRs + CI.
4. No secrets ever in the repository.
5. No force-pushes on protected branches.
6. One logical change per PR (one issue per branch).
7. CI must pass before any merge.

## 2. Version Control & Branching Strategy (GitFlow + Git Town)

```text
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

Every repository **must** have the following workflows:

- `.github/workflows/ci.yml`
- `.github/workflows/release.yml`
- Language-specific files (`python-ci.yml`, `android-ci.yml`, etc.)

**Minimum checks**:

- Linting + formatting
- All tests
- Build / compile
- Security / dependency scanning

## 5. Testing & Quality Standards

- TDD mandatory
- Tests must exist and pass before merge
- Language-appropriate tools (pytest, JUnit, etc.)
- Formatting & linting **enforced** in CI
- Never suppress lint warnings, PMD rules, or static analysis findings (no
  `@SuppressWarnings`, `// noinspection`, `# noqa`, `<!-- markdownlint-disable`,
  etc.). Fix the issue or justify with a team-approved exception in the PR.

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

See `docs/extensions.md` for details.

**Python**  
Ruff + pyright, Docker-first, provider pattern.

**Android / Kotlin**  
Jetpack Compose + Material 3, Hilt, Room, Spotless + ktlint + Detekt (mandatory), Git Town.

**Any other language**  
Follow generic rules + add language-specific lint/test tools to CI.

## 9. Rules for Agents (AI Contributors)

AI agents (Claude Code, Codex, Copilot, Cursor, Grok, or any other) are held to the **same standards** as human contributors. No exceptions.

**Before starting work**:

1. Read `CONSTITUTION.md` (or the agent instruction file: `CLAUDE.md`,
   `AGENTS.md`, `.github/copilot-instructions.md`, `.cursorrules`).
2. Identify the issue or spec being addressed.

**During development**:

1. Branch from `dev` using the correct prefix (`feat/`, `fix/`, `hotfix/`,
   `release/`).
2. Follow TDD — write a failing test first, then implement, then refactor.
3. Never commit directly to `main` or `dev`.
4. Run linter, formatter, and full test suite before pushing.
5. Reference the issue number in commit messages.

**When submitting**:

1. Create a PR using the repository's PR template.
2. Ensure all CI checks pass.
3. Wait for human approval before merging (agents do not self-approve).

**Prohibited actions**:

- Force-pushing on any protected branch
- Bypassing CI or skipping hooks (`--no-verify`)
- Committing secrets, credentials, or `.env` files
- Making destructive changes (deleting branches, resetting history) without
  explicit human authorization

## 10. Enforcement & Evolution

- Changes to this Constitution require a PR to **this** repository.
- Violations block merges.
- Every repository must include agent instruction files (`CLAUDE.md`,
  `AGENTS.md`, `.github/copilot-instructions.md`, `.cursorrules`) so agents
  auto-discover the rules. Use templates from this repository's `templates/`
  directory.
- When Immutable Rules change, all agent instruction templates must be updated
  in the same PR.

## 11. Repository Setup & Branch Protection (One-time setup)

**Every repository (including this one) must protect `main` and `dev`.**

### How to protect `main` and `dev`

1. Go to **Settings → Branches** in the GitHub repository.
2. Click **“Add branch protection rule”**.
3. In **Branch name pattern**, type `main` and click **Create**.
4. Repeat the process and type `dev` and click **Create**.

**Required settings for both branches**:

- ✅ **Require a pull request before merging**
- ✅ **Require status checks to pass before merging** (select all CI workflows)
- ✅ **Require approval** (at least 1 reviewer)
- ✅ **Do not allow force pushes**
- (Recommended) **Require conversation resolution before merging**

**After protecting**:

- Create the `dev` branch from `main` if it doesn’t exist yet.
- All future changes (including to this Constitution) **must** go through a PR.

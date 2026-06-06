# Engineering Constitution

**Version 1.3** — June 2026  
**Author**: tlacahuepec  
**Applies to**: All repositories under tlacahuepec (software, documentation, workflow, template, artifact, or configuration repositories)

## 1. Preamble & Core Principles

We build **robust, secure, maintainable, and high-quality repositories** using:

- **Verification-First Development (VFD)** as mandatory practice
- **Test-Driven Development (TDD)** for executable production code
- **Validation-Driven Development (VDD)** for non-executable repositories such as workflow libraries, documentation repositories, prompt libraries, template repositories, configuration repositories, and other artifact-first projects
- **Specification-Driven Development (SDD)** — clear requirements before implementation (see below)
- Security and reliability by default (zero tolerance for vulnerabilities or leaked secrets)
- Cutting-edge technologies when they add clear value, while remaining technology-agnostic
- Consistency, automation, and documentation so humans **and agents** can contribute safely

**This Constitution is the single source of truth.** Every PR, commit, and CI run must comply.

### Specification-Driven Development (SDD)

Every feature, fix, or change begins with a **written spec** before any code or artifact is changed:

1. Define the problem or requirement in an issue or design document.
2. Specify inputs, outputs, acceptance criteria, validation method, and edge cases.
3. Get the spec approved (via issue assignment or PR review of the spec).
4. Only then begin implementation — guided by the spec and validated by TDD or VDD.

SDD defines **what** to build. VFD defines **how to verify** it works. TDD is the default verification method for executable code. VDD is the verification method for non-executable artifacts.

### Verification-First Development (VFD)

Every change must define its verification method before implementation.

**For executable software:**

1. Write a failing test that defines the expected behavior.
2. Run the test and confirm it fails.
3. Write the minimum production code to make the test pass.
4. Run the test and confirm it passes.
5. Refactor while keeping tests green.

**For non-executable artifacts, workflows, templates, prompts, and documentation:**

1. Write or update the spec, checklist, schema, README, or acceptance criteria first.
2. Define the strongest reasonable validation method before changing the artifact.
3. Automate validation where practical.
4. Manually validate anything that cannot be automated, and document the manual validation in the PR.
5. Preserve reproducibility: readers and agents must be able to understand how to use, validate, and safely modify the artifact.

Examples of VDD validation include JSON/YAML validation, Markdown linting, link checks, workflow import checks, dry-run instructions, schema checks, required-file checks, no-large-file checks, and secret scanning.

### Immutable Rules (apply to every repo)

1. Verification-first is mandatory — TDD for executable code, VDD for non-executable artifacts.
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
- Test or validation plan
- Checklist (see PR template)

**Merging rules** (enforced via branch protection):

- At least 1 approval
- All CI checks green
- Squash merge (clean history)
- Delete branch after merge

## 4. CI/CD Requirements (Mandatory)

Every repository **must** have CI appropriate to its contents.

Software repositories must include the following workflows where applicable:

- `.github/workflows/ci.yml`
- `.github/workflows/release.yml`
- Language-specific files (`python-ci.yml`, `android-ci.yml`, etc.)

Artifact, workflow, documentation, template, and configuration repositories must include validation CI instead of fake builds or irrelevant test suites.

**Minimum checks for software repositories**:

- Linting + formatting
- All tests
- Build / compile
- Security / dependency scanning

**Minimum checks for non-executable repositories**:

- Markdown, JSON, YAML, or relevant file-format validation
- Link checks where documentation contains links
- Required-file checks for repository conventions
- Secret scanning
- Large-file or forbidden-file checks when the repository must not store binaries, models, generated outputs, or credentials
- Repository-specific validation scripts where useful

## 5. Testing & Quality Standards

- TDD is mandatory for executable production code.
- VDD is mandatory for non-executable artifacts, workflows, prompts, templates, configuration, and documentation.
- Tests or validation checks must exist and pass before merge.
- Language-appropriate tools are required for code (pytest, JUnit, etc.).
- Artifact-appropriate tools are required for non-code repositories (JSON/YAML validation, Markdown linting, link checks, schema checks, or import/dry-run validation).
- Formatting & linting **enforced** in CI where practical.
- Never suppress lint warnings, PMD rules, or static analysis findings (no
  `@SuppressWarnings`, `// noinspection`, `# noqa`, `<!-- markdownlint-disable`,
  etc.). Fix the issue or justify with a team-approved exception in the PR.

## 6. Security & Secrets

- Use `.env.example` + GitHub Secrets when environment variables are needed.
- Enable Dependabot + secret scanning where supported.
- No secrets in code, documentation, workflow files, prompts, examples, screenshots, or history.
- Do not commit large model files, generated output batches, private images, credentials, tokens, cookies, browser exports, or local machine paths unless explicitly safe and intentional.

## 7. Documentation

- Clear `README.md`
- This `CONSTITUTION.md`
- `docs/` folder when needed
- `CHANGELOG.md` or automated releases
- For artifact/workflow repositories, every reusable artifact should include enough documentation to reproduce and validate it locally.

## 8. Technology-Specific Extensions

See `docs/extensions.md` for details.

**Python**  
Ruff + pyright, Docker-first, provider pattern.

**Android / Kotlin**  
Jetpack Compose + Material 3, Hilt, Room, Spotless + ktlint + Detekt (mandatory), Git Town.

**Artifact / Workflow repositories**  
Validation-first, reproducibility-first, no committed large binaries or generated output batches, and repository-specific validation scripts.

**Any other language or repository type**  
Follow generic rules + add language-specific or artifact-specific lint/test/validation tools to CI.

## 9. Rules for Agents (AI Contributors)

AI agents (Claude Code, Codex, Copilot, Cursor, Grok, or any other) are held to the **same standards** as human contributors. No exceptions.

**Before starting work**:

1. Read `CONSTITUTION.md` (or the agent instruction file: `CLAUDE.md`,
   `AGENTS.md`, `.github/copilot-instructions.md`, `.cursorrules`).
2. Identify the issue or spec being addressed.
3. Identify whether the repository is executable software or a non-executable artifact/workflow/documentation repository.

**During development**:

1. Branch from `dev` using the correct prefix (`feat/`, `fix/`, `hotfix/`,
   `release/`).
2. Follow VFD — use TDD for executable code, or VDD for artifacts/workflows/docs.
3. Never commit directly to `main` or `dev`.
4. Run linter, formatter, test suite, and/or validation scripts before pushing.
5. Reference the issue number in commit messages.

**When submitting**:

1. Create a PR using the repository's PR template.
2. Ensure all CI checks pass.
3. Include the test plan or validation plan.
4. Wait for human approval before merging (agents do not self-approve).

**Prohibited actions**:

- Force-pushing on any protected branch
- Bypassing CI or skipping hooks (`--no-verify`)
- Committing secrets, credentials, or `.env` files
- Committing large binaries, generated image batches, model checkpoints, private images, or machine-specific artifacts unless the repository explicitly allows them
- Making destructive changes (deleting branches, resetting history) without
  explicit human authorization
- Skipping tests or validation because the repository has no traditional production code

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

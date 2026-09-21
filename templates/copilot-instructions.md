# Copilot Instructions — Engineering Constitution

This repository is governed by the **tlacahuepec Engineering Constitution**.
Full document: https://github.com/tlacahuepec/Constitution/blob/main/CONSTITUTION.md

## Immutable Rules

1. Verification-first is mandatory — use TDD for executable code and VDD for non-executable artifacts.
2. Never push directly to `main` or `dev`.
3. All changes go through PRs with CI passing.
4. No secrets ever in the repository.
5. No force-pushes on any branch — protected or feature. History is immutable once pushed.
6. No `git commit --amend`, `git rebase`, or history rewrites after push. Create a new commit.
7. One logical change per PR (one issue per branch).
8. CI must pass before any merge.

## Verification Protocol

### Executable code

1. Write a failing test first.
2. Confirm it fails.
3. Write minimum code to pass.
4. Confirm it passes.
5. Refactor, keeping tests green.

### Artifacts, workflows, prompts, templates, and docs

1. Define acceptance criteria or validation first.
2. Update the artifact only after validation is clear.
3. Prefer automated validation.
4. Document manual validation when automation is not practical.

## Code and Artifact Generation Rules

- Check `README.md` for project tier (🧪 T1, 🔧 T2, 🏢 T3, 🚀 T4).
- Generate tests alongside executable production code.
- Write characterization tests before refactoring existing code.
- Package by Feature: organize code around business capabilities, not technical types.
- Follow Clean Architecture: inward dependency direction only (Domain → Application → Infrastructure → Presentation).
- Do not create catch-all `utils/` files; use single-purpose semantic modules.
- Limit folder depth to ≤ 4 levels from source root.
- Never mix refactoring and feature behavior changes in the same PR.
- Follow the Boy Scout Rule only on local touched lines.
- Use SOLID principles where software design is involved.
- Never generate code, docs, workflows, prompts, or examples that contain hardcoded secrets or credentials.
- Never suppress lint, PMD, or static analysis warnings. Fix the issue instead.
- Prefer small, focused changes over large refactors.
- Do not commit large model files, generated output batches, private images, or machine-specific artifacts.

## Branch & Commit Conventions

- Always run `git fetch origin` and pull the latest base (`dev` or `main`) before branching.
- Branch prefix: `feat/`, `fix/`, `hotfix/`, `release/`
- Keep feature branches synced with the base branch regularly during development.
- Commit message: imperative mood, reference issue, < 72 chars.
- Example: `Add user authentication module (#42)`
- Never force-push or amend pushed commits.

## Full Standards

Read `CONSTITUTION.md` in this repository for complete rules.

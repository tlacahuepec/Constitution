# Copilot Instructions — Engineering Constitution

This repository is governed by the **tlacahuepec Engineering Constitution**.
Full document: https://github.com/tlacahuepec/Constitution/blob/main/CONSTITUTION.md

## Immutable Rules

1. Verification-first is mandatory — use TDD for executable code and VDD for non-executable artifacts.
2. Never push directly to `main` or `dev`.
3. All changes go through PRs with CI passing.
4. No secrets ever in the repository.
5. No force-pushes on protected branches.
6. One logical change per PR (one issue per branch).
7. CI must pass before any merge.

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

- Generate tests alongside executable production code.
- Generate validation scripts/checklists alongside non-executable artifacts where practical.
- Use SOLID principles where software design is involved.
- Follow the repository's existing patterns and conventions.
- Never generate code, docs, workflows, prompts, or examples that contain hardcoded secrets or credentials.
- Never suppress lint, PMD, or static analysis warnings. Fix the issue instead.
- Prefer small, focused changes over large refactors.
- Do not commit large model files, generated output batches, private images, or machine-specific artifacts unless explicitly allowed.

## Branch & Commit Conventions

- Branch prefix: `feat/`, `fix/`, `hotfix/`, `release/`
- Commit message: imperative mood, reference issue, < 72 chars
- Example: `Add user authentication module (#42)`

## Full Standards

Read `CONSTITUTION.md` in this repository for complete rules.

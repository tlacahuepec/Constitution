# Copilot Instructions — Engineering Constitution

This repository is governed by the **tlacahuepec Engineering Constitution**.
Full document: https://github.com/tlacahuepec/Constitution/blob/main/CONSTITUTION.md

## Immutable Rules

1. TDD is mandatory — write failing tests BEFORE production code.
2. Never push directly to `main` or `dev`.
3. All changes go through PRs with CI passing.
4. No secrets ever in the repository.
5. No force-pushes on protected branches.
6. One logical change per PR (one issue per branch).
7. CI must pass before any merge.

## TDD Protocol

1. Write a failing test first.
2. Confirm it fails.
3. Write minimum code to pass.
4. Confirm it passes.
5. Refactor, keeping tests green.

## Code Generation Rules

- Always generate tests alongside production code.
- Use SOLID principles.
- Follow the repository's existing patterns and conventions.
- Never generate code that contains hardcoded secrets or credentials.
- Never suppress lint, PMD, or static analysis warnings. Fix the issue instead.
- Prefer small, focused changes over large refactors.

## Branch & Commit Conventions

- Branch prefix: `feat/`, `fix/`, `hotfix/`, `release/`
- Commit message: imperative mood, reference issue, < 72 chars
- Example: `Add user authentication module (#42)`

## Full Standards

Read `CONSTITUTION.md` in this repository for complete rules.

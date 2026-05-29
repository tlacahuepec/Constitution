# Project Rules (Engineering Constitution)

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

## TDD Protocol (mandatory)

1. Write a failing test that defines the expected behavior.
2. Run the test — confirm it fails.
3. Write the minimum code to make the test pass.
4. Run the test — confirm it passes.
5. Refactor if needed, ensuring tests still pass.

## Workflow

- Branch from `dev` using `feat/`, `fix/`, `hotfix/`, or `release/` prefix.
- Commit messages: imperative mood, reference issue, < 72 chars.
- Before pushing: run linter, formatter, and full test suite.
- PR must include: issue link, summary, test plan, checklist.

## Agent-Specific Rules

- Read `CONSTITUTION.md` before starting any work.
- Never commit directly to `main` or `dev`.
- Never bypass CI or skip hooks (`--no-verify`).
- Never suppress lint, PMD, or static analysis warnings. Fix the issue instead.
- Never self-approve — wait for human review.
- Never make destructive changes without explicit human authorization.
- Always add tests. If existing code lacks tests, add them.
- Use SOLID principles. Prefer small, focused changes.

## Full Standards

Read `CONSTITUTION.md` in this repository for complete standards on branching, CI/CD, security, documentation, and technology-specific extensions.

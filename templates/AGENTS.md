# AGENTS.md — Engineering Constitution

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

## DO NOT

- Do NOT commit directly to `main` or `dev`.
- Do NOT bypass CI or skip hooks (`--no-verify`).
- Do NOT suppress lint, PMD, or static analysis warnings. Fix the issue instead.
- Do NOT self-approve PRs — wait for human review.
- Do NOT commit secrets, credentials, or `.env` files.
- Do NOT make destructive changes (delete branches, reset history) without explicit human authorization.
- Do NOT skip writing tests. TDD is non-negotiable.

## Full Standards

Read `CONSTITUTION.md` in this repository for complete standards on branching, CI/CD, security, documentation, and technology-specific extensions.

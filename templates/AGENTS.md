# AGENTS.md — Engineering Constitution

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

## Verification Protocol (mandatory)

### For executable code

1. Write a failing test that defines the expected behavior.
2. Run the test and confirm it fails.
3. Write the minimum code to make the test pass.
4. Run the test and confirm it passes.
5. Refactor if needed, ensuring tests still pass.

### For artifacts, workflows, prompts, templates, and docs

1. Write or update the spec, checklist, schema, README, or acceptance criteria first.
2. Define validation before changing the artifact.
3. Automate validation where practical.
4. Document manual validation in the PR when automation is not practical.
5. Preserve reproducibility and safety.

## Workflow

- Branch from `dev` using `feat/`, `fix/`, `hotfix/`, or `release/` prefix.
- Commit messages: imperative mood, reference issue, < 72 chars.
- Before pushing: run linter, formatter, tests, and/or validation scripts.
- PR must include: issue link, summary, test or validation plan, checklist.

## DO NOT

- Do NOT commit directly to `main` or `dev`.
- Do NOT bypass CI or skip hooks (`--no-verify`).
- Do NOT suppress lint, PMD, or static analysis warnings. Fix the issue instead.
- Do NOT self-approve PRs — wait for human review.
- Do NOT commit secrets, credentials, or `.env` files.
- Do NOT commit large model files, generated output batches, private images, or machine-specific artifacts unless explicitly allowed.
- Do NOT make destructive changes (delete branches, reset history) without explicit human authorization.
- Do NOT skip tests or validation because the repository has no traditional production code.

## Full Standards

Read `CONSTITUTION.md` in this repository for complete standards on branching, CI/CD, security, documentation, and technology-specific extensions.

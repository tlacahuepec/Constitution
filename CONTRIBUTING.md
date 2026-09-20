# Contributing Guide

Thank you for contributing!

**All contributions must follow the [Engineering Constitution](./CONSTITUTION.md).**

## How to Contribute

1. Read the full [Engineering Constitution](./CONSTITUTION.md).
2. Create or find an issue describing the work (for significant changes, include or link a written specification following SDD).
3. Create a branch using the correct naming convention (`feat/`, `fix/`, `release/`, `hotfix/`).
4. Follow **Verification-First Development (VFD)**:
   - **Executable software**: Follow TDD — write failing tests before implementation.
   - **Non-executable artifacts/docs**: Follow VDD — define validation criteria and checklists before changes.
5. Make your changes, ensuring:
   - All tests and validation scripts pass.
   - Linters and formatters pass with zero warnings (never suppress warnings).
   - Code adheres to SOLID principles and readability standards.
6. Open a Pull Request using the provided template.
7. Request review from the maintainer.

Agents and AI assistants must follow the exact same process — no exceptions.

See [CONSTITUTION.md](./CONSTITUTION.md) for detailed branching, commit, PR,
CI/CD, and quality rules.

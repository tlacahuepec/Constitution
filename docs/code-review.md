# Code Review Guide & Rubric

This guide establishes the standards, principles, and expectations for **code authors and reviewers** across all repositories.

Code review is a collaborative quality gate and knowledge-sharing practice, not an adversarial inspection.

---

## 1. Principles of Code Review

1. **Constitutional Alignment**: Every PR is evaluated against the [Engineering Constitution](../CONSTITUTION.md).
2. **Small, Focused Changes**: Keep PRs small (target < 400 lines of diff). Smaller PRs receive faster, more thorough reviews with fewer defects.
3. **Automate the Mundane**: Formatters, linters, and type checkers run in CI. Reviewers should focus on architecture, correctness, security, and edge cases, not styling nits.
4. **Be Constructive & Kind**: Critique the code, never the author. Clearly explain *why* an alternative is suggested and provide concrete examples.
5. **Turnaround SLA**: Initial reviews should be provided within **24 business hours** of submission.

---

## 2. Author Responsibilities

Before requesting review:

- [ ] **Self-Review First**: Read your own full diff on GitHub before requesting review.
- [ ] **Issue Linked**: Ensure the PR references the tracked issue or spec (`Closes #XX`).
- [ ] **Green CI**: All CI workflows (tests, linters, security scans) must pass before requesting human review.
- [ ] **Test / Validation Plan**: Document exact steps and commands used to verify the change.
- [ ] **No Warning Suppressions**: Verify zero `@SuppressWarnings`, `# noqa`, or `// noinspection` were added.
- [ ] **No Unanchored TODOs**: Ensure all `TODO` comments reference an issue (`TODO(#123)`).

---

## 3. Reviewer Rubric & Classification

When leaving comments, reviewers must clearly distinguish between **blocking issues** and **non-blocking suggestions**:

### Blocking Comments (Must be addressed before merge)
Use blocking comments for issues affecting correctness, security, or constitutional standards:

- **Correctness & Bugs**: Off-by-one errors, race conditions, null-pointer risks, unhandled edge cases.
- **Security Vulnerabilities**: Injection risks, exposed secrets, missing input validation, broken access control.
- **Constitutional Violations**:
  - Missing tests or failing verification-first practice.
  - Suppressed linter or compiler warnings.
  - Unreferenced `TODO` comments.
  - Function length exceeding 50 lines or cyclomatic complexity exceeding 10 without justification.
  - SOLID violations (God classes, hardcoded concrete dependencies).
- **Breaking Changes**: Undocumented breaking API or schema changes without deprecation windows.

### Non-Blocking Comments (Can be merged without resolving)
Prefix non-blocking comments with `nit:` or `suggestion:` so the author knows the PR is not blocked:

- `nit: rename 'data' to 'userProfile' for additional clarity.`
- `suggestion: this could also be written using pattern matching, but current code is acceptable.`
- `question: out of curiosity, did we consider using a Set here instead of a List?`

---

## 4. Code Review Checklist

Reviewers should systematically evaluate the following five dimensions:

### A. Architecture & Design
- Does the change honor SOLID principles?
- Are abstractions well-placed?
- Are layers properly separated (domain logic vs persistence vs transport)?
- Is significant architectural impact documented via an ADR in `docs/adr/`?

### B. Readability & Code Quality
- Are functions focused (≤ 30 lines) and files modular (≤ 300 lines)?
- Is indentation depth ≤ 3?
- Are variable and method names domain-descriptive and pronounceable?
- Do inline comments explain *why*, not *what*?
- Do public APIs have docstrings?

### C. Testing & Verification
- Are tests structured using Arrange-Act-Assert (AAA)?
- Do tests verify behavior and edge cases, not just happy-path coverage?
- Does test coverage meet or exceed 80%?
- Are domain objects real instances (no mocking of internal domain models)?

### D. Security & Boundaries
- Is all untrusted input validated at the controller/gateway boundary?
- Are database queries parameterized?
- Are any credentials, keys, or PII exposed in code, logs, or error responses?

### E. Error Handling & Observability
- Are domain-specific exceptions used instead of generic `Exception`?
- Are exceptions handled cleanly without swallowed `catch` blocks?
- Are logs structured as JSON with semantic levels and request correlation IDs?

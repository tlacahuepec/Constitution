# Engineering Constitution

**Version 2.0** — September 2026  
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

### Semantic Versioning (SemVer 2.0.0)

All repositories releasing versioned packages, APIs, or software artifacts must adhere strictly to [SemVer 2.0.0](https://semver.org/):

- **MAJOR (`X.0.0`)**: Incompatible API changes, breaking data schema changes, or removed features.
- **MINOR (`0.X.0`)**: Backward-compatible new functionality, new endpoints, or non-breaking extensions.
- **PATCH (`0.0.X`)**: Backward-compatible bugfixes, security patches, or internal performance improvements.
- **Deprecation Policy**: Features, endpoints, or APIs scheduled for removal must be marked `@deprecated` (with clear migration guidance in docs) for at least one MINOR release cycle prior to removal in the next MAJOR release.

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

### Environment Management & Deployment Strategies

1. **Environment Tiers**:
   - **Local**: Development workstations with mocked or containerized local services.
   - **Development (`dev`)**: Continuous integration environment automatically deployed on merge to `dev`.
   - **Staging**: Production-mirror environment with anonymized or synthetic data for pre-release validation.
   - **Production (`main`)**: Production environment deployed only from verified releases.
2. **Twelve-Factor Configuration**:
   - Configuration must strictly be separated from code and injected via environment variables.
   - Code artifacts (container images, binaries) must be identical across staging and production.
3. **Zero-Downtime Deployment Patterns**:
   - Deployments must utilize **Blue/Green** or **Canary** rollout strategies.
   - Production deployments must verify the `/readyz` endpoint before shifting traffic.
   - Automated rollback triggers must revert deployments instantly if error rates spike (> 1%) or latency exceeds thresholds.

## 5. Testing, Quality & Code Design Standards

### Testing & Verification Standards

- TDD is mandatory for executable production code.
- VDD is mandatory for non-executable artifacts, workflows, prompts, templates, configuration, and documentation.
- Tests or validation checks must exist and pass before merge.
- Language-appropriate tools are required for code (pytest, JUnit, etc.).
- Artifact-appropriate tools are required for non-code repositories (JSON/YAML validation, Markdown linting, link checks, schema checks, or import/dry-run validation).
- Formatting & linting **enforced** in CI where practical.

#### The Test Pyramid & Testing Depth

Executable software repositories must balance their test suites according to the Test Pyramid:

1. **Unit Tests (70–80% of test suite)**:
   - Validate isolated domain logic, business rules, algorithms, and models in memory.
   - Must be fast (sub-second), deterministic, and execute without network, filesystem, or database I/O.
2. **Integration Tests (15–20% of test suite)**:
   - Validate interactions between modules and external boundaries (database queries, repository implementations, API controllers, message queues).
   - Use ephemeral test databases (in-memory or Testcontainers).
3. **End-to-End (E2E) & Contract Tests (5–10% of test suite)**:
   - Validate critical user journeys and consumer-driven API contracts.

#### Test Structure & Naming

- Every test must follow the **Arrange-Act-Assert (AAA)** or **Given-When-Then** pattern with clear visual separation between setup, execution, and assertion.
- Test names must explicitly describe the scenario and expected outcome: `test_<methodUnderTest>_<condition>_<expectedResult>()` or `should_<expectedResult>_when_<condition>()`.

#### Mocking & Test Double Policies

- **Never mock internal domain entities or business logic**: Domain models must always be real instances. If tests require mocking domain logic, the architecture is tightly coupled and must be refactored.
- **Only mock external I/O boundaries**: Mock third-party HTTP APIs, payment gateways, external notification services, and network clients.
- **Favor in-memory fakes over deep mock hierarchies**: When simulating an interface, write a simple in-memory fake implementation rather than complex, brittle mocking configurations.

### SOLID Principles (Mandatory for OOP and Modular Systems)

Every executable codebase must adhere to the SOLID principles:

1. **Single Responsibility Principle (SRP)**:
   - A class, module, or function must have one, and only one, reason to change.
   - Separate business logic, persistence, and presentation into distinct layers.
   - Classes exceeding 300 lines or functions with multiple responsibilities are considered SRP violations.
2. **Open/Closed Principle (OCP)**:
   - Software entities should be open for extension, but closed for modification.
   - Use interfaces, polymorphism, and dependency injection to allow new behaviors without modifying existing, tested code.
3. **Liskov Substitution Principle (LSP)**:
   - Subtypes must be substitutable for their base types without altering program correctness.
   - Subclasses must honor the base contract and never throw unexpected exceptions (e.g., `UnsupportedOperationException`) on base methods.
4. **Interface Segregation Principle (ISP)**:
   - Clients should not be forced to depend on interfaces they do not use.
   - Prefer small, highly-cohesive interfaces over fat, monolithic ones.
5. **Dependency Inversion Principle (DIP)**:
   - High-level modules must not depend on low-level modules; both must depend on abstractions.
   - Abstractions must not depend on details; details must depend on abstractions.
   - Use dependency injection to supply dependencies.

### Code Readability & Writing Standards

Code is read far more often than it is written. Clean, readable code is non-negotiable:

- **Function / Method Length**: Target ≤ 30 lines. Absolute ceiling of 50 lines without documented justification.
- **File Length**: Target ≤ 300 lines. Absolute ceiling of 500 lines. Break large files into cohesive modules.
- **Cyclomatic Complexity**: Maximum of 10 per function/method. Functions exceeding complexity 10 must be refactored into smaller, focused helpers.
- **Nesting Depth**: Maximum of 3 levels of indentation (`if`, loops, matches). Flatten code using guard clauses and early returns.
- **Semantic Naming Conventions**:
  - Variable, function, and class names must be descriptive, pronounceable, and domain-accurate.
  - Avoid cryptic abbreviations (use `userRepository`, not `uRepo` or `ur`).
  - No single-letter variables except short loop indices (`i`, `j`).
  - Booleans must read as assertions or predicates: `isEnabled`, `hasAccess`, `isComplete`.
- **Comments & Self-Documenting Code**:
  - Code should explain *what* it does through clear naming and structure.
  - Inline comments must explain *why* something is done (business context, non-obvious constraints), never *what* the code does.
  - Public APIs, interfaces, and exported functions require docstrings (Javadoc, Python docstrings, JSDoc).
- **Prohibition on Warning Suppressions**:
  - Never suppress lint warnings, PMD rules, or static analysis findings (no `@SuppressWarnings`, `// noinspection`, `# noqa`, `<!-- markdownlint-disable`, etc.). Fix the root cause.
- **Technical Debt Management**:
  - Every `TODO` or `FIXME` comment in code must reference a tracked issue: `TODO(#123): explanation`.
  - Unreferenced `TODO` or `FIXME` comments are prohibited and must be blocked during code review.
  - Teams should allocate ≥ 10% of engineering capacity to technical debt reduction and refactoring.

## 6. Security, Input Validation & Secrets

- **Zero-Tolerance for Secrets**: Never commit secrets, credentials, tokens, or private keys. Use `.env.example` + GitHub Secrets.
- **Secret Scanning**: Enable Dependabot and automated secret scanning on all repositories.
- **Input Validation & System Boundaries**:
  - Never trust external or user-supplied input. All data entering the system (HTTP bodies, query params, headers, CLI arguments, file uploads, message queues) must be validated and sanitized at the boundary (controller, handler, gateway) using type-safe schema validators (e.g. Pydantic, Zod, Jakarta Bean Validation).
  - Domain logic must receive pre-validated, strongly-typed domain models, never raw strings or unverified payloads.
  - Input validation failures must immediately return structured 400-series client errors without executing domain logic.
- **Forbidden Files**: Do not commit large model files, generated output batches, private images, credentials, tokens, cookies, browser exports, or local machine paths unless explicitly safe and intentional.
- **OWASP Top 10 Compliance**: Follow the mandatory security mitigations in [`docs/security.md`](./docs/security.md).

## 7. Logging, Error Handling & Architecture Decisions

### Structured Logging Standards

- Services must use structured JSON logging.
- Log levels must be semantic:
  - `DEBUG`: Verbose diagnostic information (disabled in production).
  - `INFO`: Normal operational events (startup, shutdown, completed significant transactions).
  - `WARN`: Recoverable issues, degraded performance, or unexpected non-fatal events.
  - `ERROR`: Unrecoverable errors affecting a request or operation requiring engineer intervention.
- Every inbound request must be assigned a correlation ID (`X-Correlation-ID` / trace ID) propagated across all log entries.
- **Prohibition on Sensitive Data in Logs**: Never log passwords, API keys, bearer tokens, cookies, credit card numbers, or personally identifiable information (PII). Redact sensitive fields before writing logs.

### Error Handling Standards

- Define domain-specific exception hierarchies. Avoid throwing generic `Exception` or `RuntimeException`.
- Never silently catch exceptions (no empty catch blocks or bare `except:`). Always log or translate errors.
- API errors must return consistent structured envelopes (RFC 7807 Problem Details recommended).
- Fail fast on startup if configuration or required dependencies are missing.

### Monitoring, Metrics & Tracing

- Services must expose `/healthz` (liveness) and `/readyz` (readiness) endpoints.
- Collect and track the Four Golden Signals (Latency, Traffic, Errors, Saturation).
- Follow the observability standards in [`docs/observability.md`](./docs/observability.md).

### Documentation, APIs & Architecture Decisions

- Clear `README.md`
- This `CONSTITUTION.md`
- `docs/` folder when needed
- `CHANGELOG.md` or automated releases
- **API Documentation (OpenAPI 3.x)**: All HTTP services must maintain an OpenAPI 3.x specification generated from code or validated against code in CI to prevent contract drift.
- **Architecture Decision Records (ADRs)**: All significant architectural decisions (framework choices, persistence strategies, API contracts, cross-cutting patterns) must be recorded as an ADR in `docs/adr/` using `templates/ADR_TEMPLATE.md`.
- **Incident Management & Blameless Post-Mortems**: Production outages (SEV1/SEV2) require a blameless post-mortem retrospective conducted within 5 business days using `templates/POST_MORTEM_TEMPLATE.md`. Action items must be tracked as GitHub issues.

## 8. Technology-Specific Extensions

See `docs/extensions.md` for details.

**Python**  
Ruff + pyright, Docker-first, provider pattern.

**Android / Kotlin**  
Jetpack Compose + Material 3, Hilt, Room, Spotless + ktlint + Detekt (mandatory), Git Town.

**Java / JVM**  
Google Java Format + SpotBugs + Error Prone, JUnit 5 + JaCoCo (≥ 80% coverage), Clean Architecture or Hexagonal, Javadoc on public APIs.

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
- Any agent or human may **audit** a repository for constitutional compliance
  using `docs/audit-guide.md`. Audit findings should be filed as issues or a
  summary PR.

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

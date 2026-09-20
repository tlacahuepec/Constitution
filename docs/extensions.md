# Technology-Specific Extensions

This document extends the [Engineering Constitution](../CONSTITUTION.md) with language-specific and repository-type-specific tooling and conventions.

All rules in the Constitution apply universally. The extensions below add **additional** requirements per technology stack or repository type.

---

## Python

| Category | Standard |
|----------|----------|
| Formatter/Linter | Ruff (replaces black, isort, flake8) |
| Type Checker | pyright — strict mode |
| Test Framework | pytest + pytest-cov (minimum 80% coverage) |
| Dependencies | uv or pip-compile (pinned, reproducible) |
| Containerization | Docker-first — multi-stage builds |
| Architecture | Provider/adapter pattern for external services |

**CI must include**: `ruff check .`, `ruff format --check .`, `pyright`, `pytest --cov --cov-fail-under=80`

---

## Android / Kotlin

| Category | Standard |
|----------|----------|
| UI Framework | Jetpack Compose + Material 3 |
| Dependency Injection | Hilt |
| Database | Room |
| Formatting | Spotless + ktlint |
| Static Analysis | Detekt (all default rules enabled) |
| Architecture | MVVM + Clean Architecture (presentation/domain/data layers) |
| Branching | Git Town strongly recommended for stacked PRs |

**CI must include**: `./gradlew spotlessCheck`, `./gradlew detekt`, `./gradlew testDebugUnitTest`, `./gradlew assembleDebug`

---

## TypeScript / Node.js

| Category | Standard |
|----------|----------|
| Formatter/Linter | Biome (preferred) or ESLint + Prettier |
| Type Safety | `strict: true` in tsconfig.json |
| Test Framework | Vitest (preferred) or Jest |
| Package Manager | pnpm (preferred) |
| Build | esbuild or Vite |

**CI must include**: lint, type-check (`tsc --noEmit`), test, build

---

## Java / JVM

| Category | Standard |
|----------|----------|
| Formatter | Google Java Format (preferred) or Checkstyle with Google style |
| Static Analysis | SpotBugs + Error Prone (mandatory) |
| Test Framework | JUnit 5 + JaCoCo (minimum 80% coverage) |
| Build Tool | Gradle (preferred) or Maven with dependency locking |
| Architecture | Clean Architecture or Hexagonal (ports/adapters) |
| Dependency Injection | Spring (Boot) or Dagger/Guice |

**CI must include**: `./gradlew spotlessCheck` (or checkstyle), `./gradlew spotbugsMain`, `./gradlew test jacocoTestReport`, `./gradlew build`

**Additional rules**:

- No `@SuppressWarnings` without a team-approved exception documented in the PR.
- All public API classes and methods must have Javadoc.
- Use `Optional` instead of returning `null` from public methods.
- Prefer immutable data structures and records (Java 17+).
- Use sealed classes/interfaces for closed type hierarchies where applicable.

---

## Artifact / Workflow / Documentation Repositories

Use this extension for repositories whose main deliverable is not executable production code, including:

- ComfyUI workflow libraries
- Prompt libraries
- Documentation repositories
- Template repositories
- Configuration repositories
- Design or architecture artifact repositories
- Example collections

These repositories follow **Validation-Driven Development (VDD)** instead of pretending every change can use traditional TDD.

| Category | Standard |
|----------|----------|
| Development method | VDD — validation method defined before artifact changes |
| Required docs | README plus artifact-level docs for reusable artifacts |
| Required validation | File-format validation, required-file checks, secret checks, and forbidden-file checks |
| Preferred scripts | `scripts/validate-*` scripts runnable locally and in CI |
| Forbidden by default | Secrets, local env files, large binaries, model checkpoints, generated output batches, private images |
| PR evidence | Validation plan, manual validation notes if automation is not practical |

### Minimum CI for artifact repositories

CI must include the strongest practical subset of:

- Markdown linting
- JSON validation
- YAML validation
- Link checking
- Required-file checks
- Secret scanning
- Large-file / forbidden-file detection
- Repository-specific validation scripts

### ComfyUI workflow repository standard

A ComfyUI workflow repository should include:

```text
workflows/
  <workflow-type>/
    <workflow-name>/
      workflow-v1.json
      README.md
      prompt.md
      settings.md

docs/
  setup-comfyui.md
  required-custom-nodes.md
  model-registry.md
  troubleshooting.md

prompts/
  <theme>/
```

Each workflow README should document:

- Purpose
- Required model family
- Required custom nodes
- Expected local model locations
- Input files required, if any
- Recommended resolution and settings
- Import steps
- Validation steps
- Known limitations
- Troubleshooting notes

ComfyUI workflow validation should include:

- Workflow JSON parses successfully
- README exists next to each reusable workflow
- Required model family is documented
- Required custom nodes are documented or explicitly marked as none/TBD
- No model checkpoints are committed
- No generated image batches are committed
- Manual import test documented in the PR when practical

---

## API Design Standards (RESTful Services)

All HTTP APIs must adhere to standard RESTful design conventions:

1. **Resource-Oriented URIs**:
   - Use plural nouns for resource collections: `/api/v1/orders`, `/api/v1/users`.
   - Represent hierarchical relationships naturally: `/api/v1/users/{userId}/orders`.
   - Never use verbs in paths (use `POST /api/v1/orders`, NOT `/api/v1/createOrder`).
2. **HTTP Verb Semantics**:
   - `GET`: Safe and idempotent retrieval. Never produces side effects.
   - `POST`: Resource creation or non-idempotent operations. Returns `201 Created` with a `Location` header.
   - `PUT`: Complete resource replacement (idempotent).
   - `PATCH`: Partial resource update.
   - `DELETE`: Resource removal (idempotent). Returns `204 No Content`.
3. **Standard HTTP Status Codes**:
   - `200 OK`: Successful retrieval or synchronous update.
   - `201 Created`: Successful creation of a resource.
   - `204 No Content`: Successful action with no return payload.
   - `400 Bad Request`: Validation failure or malformed payload.
   - `401 Unauthorized`: Missing, expired, or invalid authentication credentials.
   - `403 Forbidden`: Authenticated identity lacks required permissions.
   - `404 Not Found`: Target resource does not exist.
   - `409 Conflict`: Conflict with current state (e.g. unique constraint violation).
   - `422 Unprocessable Entity`: Syntactically valid JSON, but fails semantic business validation.
   - `500 Internal Server Error`: Unhandled server exception.
4. **Pagination**:
   - Large or unbounded collections must enforce cursor-based pagination: `?limit=20&cursor=dXNlcl8xMjM=`.
   - Responses must return a standard envelope: `{ "data": [...], "hasMore": true, "nextCursor": "..." }`.
5. **API Versioning**:
   - All public APIs must be versioned in the URI path (`/v1/`) to guarantee backward compatibility.

---

## Database Design & Migration Policy

1. **Version-Controlled Migrations**:
   - All database schema changes must be version-controlled using migration tools (Flyway, Liquibase, Alembic, Prisma).
   - Never execute manual DDL statements in staging or production.
2. **Zero-Downtime / Expand-and-Contract Pattern**:
   - Schema migrations must remain backward-compatible with active application instances.
   - **Phase 1 (Expand)**: Add new columns, tables, or nullable fields.
   - **Phase 2 (Deploy)**: Deploy application code that writes to the new structure.
   - **Phase 3 (Contract)**: Remove deprecated columns or tables in a subsequent, separate release.
3. **Indexing Discipline**:
   - Every foreign key column must have an explicit index.
   - Any column used in `WHERE`, `ORDER BY`, or `JOIN` conditions on high-cardinality tables must be indexed.
4. **Transaction Boundaries**:
   - Keep database transactions as short as possible.
   - **Never hold database transactions open during external I/O** (network calls, email sending, third-party API calls).

---

## Accessibility (a11y) Standards

All user-facing frontend web applications and mobile interfaces must comply with **WCAG 2.1 Level AA** standards:

1. **Semantic HTML & Native Elements**:
   - Use standard semantic HTML5 elements (`<button>`, `<a href>`, `<nav>`, `<main>`, `<header>`, `<article>`) instead of generic `<div>` elements with `onClick` handlers.
   - All interactive controls must have accessible names (`aria-label` or visible text).
2. **Keyboard Navigation & Focus Management**:
   - All interactive elements must be fully operable using keyboard alone (`Tab`, `Shift+Tab`, `Enter`, `Space`, `Escape`).
   - Focus order must follow a logical reading sequence.
   - Never remove visible focus rings (`outline: none` without a custom `:focus-visible` replacement is prohibited).
3. **Contrast Ratios**:
   - Normal text (< 18pt or < 14pt bold) must maintain a minimum contrast ratio of **4.5:1** against its background.
   - Large text (≥ 18pt or ≥ 14pt bold) and active UI components must maintain a minimum contrast ratio of **3.0:1**.
4. **Images & Media**:
   - Every informative `<img>` must provide descriptive `alt` text. Decorative images must specify `alt=""`.
   - Video and audio content must provide captions or transcripts.
5. **Automated Accessibility Testing in CI**:
   - Frontend web repositories must execute automated accessibility checks using `@axe-core/playwright`, `cypress-axe`, or `pa11y` in CI, failing builds on critical or serious violations.

---

## General (Coding Projects / Any Language)

This section applies to repositories that contain executable production code, regardless of language.

Every coding repository, regardless of technology, **must** have:

1. A linter configured and enforced in CI
2. A formatter configured and enforced in CI
3. A test runner configured and enforced in CI
4. Dependency/security scanning enabled (Dependabot or equivalent)
5. A `.env.example` file if environment variables are used (never commit actual `.env`)

If your language is not listed above, follow the General rules and add the language-appropriate tools to CI. Document your choices in the repository's `README.md`.

---

## General (Any Repository Type)

Every repository, regardless of technology or artifact type, **must** have:

1. A clear README.
2. CI appropriate to the repository contents.
3. A test or validation strategy documented in the README or `docs/`.
4. Dependency/security scanning enabled where applicable.
5. A `.env.example` file if environment variables are used (never commit actual `.env`).

If your repository type is not listed above, follow the closest matching extension and add the appropriate lint/test/validation tools to CI. Document your choices in the repository's `README.md`.

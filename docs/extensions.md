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

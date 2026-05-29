# Technology-Specific Extensions

This document extends the [Engineering Constitution](../CONSTITUTION.md) with language-specific tooling and conventions.

All rules in the Constitution apply universally. The extensions below add **additional** requirements per technology stack.

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

## General (Any Language)

Every repository, regardless of technology, **must** have:

1. A linter configured and enforced in CI
2. A formatter configured and enforced in CI
3. A test runner configured and enforced in CI
4. Dependency/security scanning enabled (Dependabot or equivalent)
5. A `.env.example` file if environment variables are used (never commit actual `.env`)

If your language is not listed above, follow the General rules and add the language-appropriate tools to CI. Document your choices in the repository's `README.md`.

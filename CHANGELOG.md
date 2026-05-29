# Changelog

All notable changes to the Engineering Constitution will be documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/).

## [1.2] - 2026-05-29

### Added

- Specification-Driven Development (SDD) definition in Section 1
- Expanded Rules for Agents (Section 9) with full protocol
- Agent instruction templates (`templates/` directory) for Claude Code, Codex, Copilot, and Cursor
- `docs/extensions.md` with language-specific standards (Python, Android/Kotlin, TypeScript)
- `scripts/adopt.sh` for automated setup of agent files in child repos
- Real CI workflows (markdown linting, link checking, YAML validation)
- Release workflow triggered on tags
- This CHANGELOG

### Changed

- Section 10 (Enforcement) now requires agent instruction files in every repo
- CI workflow replaced placeholder echo commands with real checks
- README updated with adoption instructions

## [1.1] - 2026-05-28

### Added

- Branch protection setup guide (Section 11)
- Linked issue requirement in PR template

## [1.0] - 2026-05-27

### Added

- Initial Engineering Constitution
- CI workflow template
- PR template
- Contributing guide

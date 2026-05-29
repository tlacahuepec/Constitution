# Engineering Constitution

This repository contains the official **Engineering Constitution** that governs **all** software development across every tlacahuepec repository.

It defines the non-negotiable standards for:

- Branching & Git workflow
- CI/CD
- Merging rules
- Testing (TDD)
- Code quality
- Security
- Documentation
- Contribution process

**This is the single source of truth.** Every repository (Python, Kotlin/Android, Java, TypeScript, Pascal, Assembly, or any other technology) must follow it.

## Quick Links

- [Full Constitution](./CONSTITUTION.md)
- [Technology Extensions](./docs/extensions.md)
- [Contributing Guide](./CONTRIBUTING.md)
- [Changelog](./CHANGELOG.md)

---

## Adopting the Constitution in Your Repository

### Automatic Setup

Run the adoption script to install agent instruction files into any repo:

```bash
git clone https://github.com/tlacahuepec/Constitution.git /tmp/constitution
/tmp/constitution/scripts/adopt.sh /path/to/your/repo
```

This installs:

| File | Platform |
|------|----------|
| `CLAUDE.md` | Claude Code |
| `AGENTS.md` | OpenAI Codex |
| `.github/copilot-instructions.md` | GitHub Copilot |
| `.cursorrules` | Cursor |

### Manual Setup

1. Copy `templates/CLAUDE.md` → your repo root as `CLAUDE.md`
2. Copy `templates/AGENTS.md` → your repo root as `AGENTS.md`
3. Copy `templates/copilot-instructions.md` → `.github/copilot-instructions.md`
4. Copy `templates/cursorrules` → `.cursorrules`
5. (Optional) Copy `CONSTITUTION.md` to your repo root for offline agent access
6. Configure branch protection per [Section 11](./CONSTITUTION.md#11-repository-setup--branch-protection-one-time-setup)

### Keeping Up to Date

Templates reference the canonical Constitution URL. Agents with network access fetch the latest version. For offline compliance, re-run the adoption script periodically or copy updated templates manually.

---

## For AI Agents

If you are an AI agent reading this repository: read [CONSTITUTION.md](./CONSTITUTION.md) in full before contributing. All rules are mandatory and enforced via CI and branch protection.

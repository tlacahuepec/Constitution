#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/../templates"
FORCE=false

usage() {
    echo "Usage: $0 [-f|--force] <target-repo-path>"
    echo ""
    echo "Copies Engineering Constitution agent instruction files into a target repository."
    echo ""
    echo "Options:"
    echo "  -f, --force    Overwrite existing files without prompting"
    echo "  -h, --help     Show this help message"
    echo ""
    echo "Files installed:"
    echo "  CLAUDE.md                         (Claude Code)"
    echo "  AGENTS.md                         (OpenAI Codex)"
    echo "  .github/copilot-instructions.md   (GitHub Copilot)"
    echo "  .cursorrules                      (Cursor)"
    exit 0
}

copy_file() {
    local src="$1"
    local dest="$2"

    if [ -f "$dest" ] && [ "$FORCE" = false ]; then
        echo "  SKIP: $dest (already exists, use --force to overwrite)"
        return
    fi

    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "  OK:   $dest"
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--force) FORCE=true; shift ;;
        -h|--help) usage ;;
        *) TARGET="$1"; shift ;;
    esac
done

if [ -z "${TARGET:-}" ]; then
    echo "Error: No target repository path provided."
    echo ""
    usage
fi

if [ ! -d "$TARGET" ]; then
    echo "Error: '$TARGET' is not a directory."
    exit 1
fi

if [ ! -d "$TARGET/.git" ]; then
    echo "Warning: '$TARGET' does not appear to be a git repository."
    echo ""
fi

echo "Installing Engineering Constitution agent files into: $TARGET"
echo ""

copy_file "$TEMPLATES_DIR/CLAUDE.md" "$TARGET/CLAUDE.md"
copy_file "$TEMPLATES_DIR/AGENTS.md" "$TARGET/AGENTS.md"
copy_file "$TEMPLATES_DIR/copilot-instructions.md" "$TARGET/.github/copilot-instructions.md"
copy_file "$TEMPLATES_DIR/cursorrules" "$TARGET/.cursorrules"

echo ""
echo "Done. Remember to:"
echo "  1. Configure branch protection for 'main' and 'dev' (see Constitution Section 11)"
echo "  2. Commit the new files to your repository"
echo "  3. Optionally copy CONSTITUTION.md to your repo root for offline agent access"

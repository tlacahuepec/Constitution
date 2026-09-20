#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/../templates"
FORCE=false
INSTALL_AGENTS=false
INSTALL_TEMPLATES=false
WORKFLOW_TYPE=""

usage() {
    echo "Usage: $0 [OPTIONS] <target-repo-path>"
    echo ""
    echo "Installs Engineering Constitution files and templates into a target repository."
    echo ""
    echo "Options:"
    echo "  -a, --agents       Install only AI agent instruction files"
    echo "  -t, --templates    Install only repository templates (PR, Spec, ADR, Checklist, Security)"
    echo "  -w, --workflow <type> Install starter CI/CD workflow (python | java | typescript | vdd)"
    echo "  --all              Install both agent files and all templates (default)"
    echo "  -f, --force        Overwrite existing files without prompting"
    echo "  -h, --help         Show this help message"
    echo ""
    echo "Agent files:"
    echo "  CLAUDE.md                         (Claude Code)"
    echo "  AGENTS.md                         (OpenAI Codex)"
    echo "  .github/copilot-instructions.md   (GitHub Copilot)"
    echo "  .cursorrules                      (Cursor)"
    echo ""
    echo "Repository templates:"
    echo "  .github/PULL_REQUEST_TEMPLATE.md  (Dual-path PR template)"
    echo "  docs/templates/SPEC_TEMPLATE.md   (SDD feature spec template)"
    echo "  docs/adr/ADR_TEMPLATE.md          (Architecture Decision Record template)"
    echo "  docs/CODE_REVIEW_CHECKLIST.md     (Code review rubric)"
    echo "  SECURITY.md                       (Security policy & vulnerability reporting)"
    echo ""
    echo "Starter workflows (-w|--workflow):"
    echo "  python, java, typescript, vdd"
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

TARGET=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -a|--agents) INSTALL_AGENTS=true; shift ;;
        -t|--templates) INSTALL_TEMPLATES=true; shift ;;
        -w|--workflow|--workflows) WORKFLOW_TYPE="$2"; shift 2 ;;
        --all) INSTALL_AGENTS=true; INSTALL_TEMPLATES=true; shift ;;
        -f|--force) FORCE=true; shift ;;
        -h|--help) usage ;;
        -*) echo "Unknown option: $1"; echo ""; usage ;;
        *) TARGET="$1"; shift ;;
    esac
done

# Default to --all if neither --agents nor --templates was explicitly selected
if [ "$INSTALL_AGENTS" = false ] && [ "$INSTALL_TEMPLATES" = false ] && [ -z "$WORKFLOW_TYPE" ]; then
    INSTALL_AGENTS=true
    INSTALL_TEMPLATES=true
fi

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

echo "Adopting Engineering Constitution into: $TARGET"
echo ""

if [ "$INSTALL_AGENTS" = true ]; then
    echo "--> Installing Agent Instruction Files..."
    copy_file "$TEMPLATES_DIR/CLAUDE.md" "$TARGET/CLAUDE.md"
    copy_file "$TEMPLATES_DIR/AGENTS.md" "$TARGET/AGENTS.md"
    copy_file "$TEMPLATES_DIR/copilot-instructions.md" "$TARGET/.github/copilot-instructions.md"
    copy_file "$TEMPLATES_DIR/cursorrules" "$TARGET/.cursorrules"
    echo ""
fi

if [ "$INSTALL_TEMPLATES" = true ]; then
    echo "--> Installing Repository Templates..."
    copy_file "$TEMPLATES_DIR/PULL_REQUEST_TEMPLATE.md" "$TARGET/.github/PULL_REQUEST_TEMPLATE.md"
    copy_file "$TEMPLATES_DIR/SPEC_TEMPLATE.md" "$TARGET/docs/templates/SPEC_TEMPLATE.md"
    copy_file "$TEMPLATES_DIR/ADR_TEMPLATE.md" "$TARGET/docs/adr/ADR_TEMPLATE.md"
    copy_file "$TEMPLATES_DIR/CODE_REVIEW_CHECKLIST.md" "$TARGET/docs/CODE_REVIEW_CHECKLIST.md"
    copy_file "$TEMPLATES_DIR/SECURITY.md" "$TARGET/SECURITY.md"
    echo ""
fi

if [ -n "$WORKFLOW_TYPE" ]; then
    case $WORKFLOW_TYPE in
        python)
            echo "--> Installing Python Starter CI Workflow..."
            copy_file "$TEMPLATES_DIR/workflows/python-ci.yml" "$TARGET/.github/workflows/ci.yml"
            ;;
        java)
            echo "--> Installing Java Starter CI Workflow..."
            copy_file "$TEMPLATES_DIR/workflows/java-ci.yml" "$TARGET/.github/workflows/ci.yml"
            ;;
        typescript|ts|node)
            echo "--> Installing TypeScript Starter CI Workflow..."
            copy_file "$TEMPLATES_DIR/workflows/typescript-ci.yml" "$TARGET/.github/workflows/ci.yml"
            ;;
        vdd|artifact|docs)
            echo "--> Installing VDD / Artifact Validation Starter CI Workflow..."
            copy_file "$TEMPLATES_DIR/workflows/vdd-ci.yml" "$TARGET/.github/workflows/ci.yml"
            ;;
        *)
            echo "Warning: Unknown workflow type '$WORKFLOW_TYPE'. Choose from: python, java, typescript, vdd."
            ;;
    esac
    echo ""
fi

echo "Done. Remember to:"
echo "  1. Configure branch protection for 'main' and 'dev' (see Constitution Section 11)"
echo "  2. Commit the new files to your repository"
echo "  3. Optionally copy CONSTITUTION.md to your repo root for offline agent access"

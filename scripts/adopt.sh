#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/../templates"
FORCE=false
INSTALL_AGENTS=false
INSTALL_TEMPLATES=false
INSTALL_GUARD=false
WORKFLOW_TYPE=""
PROJECT_TIER=""

usage() {
    echo "Usage: $0 [OPTIONS] <target-repo-path>"
    echo ""
    echo "Installs Engineering Constitution files, templates, and guard workflows into a target repository."
    echo ""
    echo "Options:"
    echo "  -a, --agents            Install only AI agent instruction files"
    echo "  -t, --templates         Install repository templates (PR, Spec, ADR, Checklist, Security, Compliance)"
    echo "  --tier <1|2|3|4>        Set project tier (1: Prototype, 2: Personal Tool, 3: Internal/Team, 4: Production)"
    echo "  -w, --workflow <type>   Install starter CI/CD workflow (python | java | typescript | vdd)"
    echo "  -g, --guard             Install Repo Guard & Tamper Defense workflow for public repos"
    echo "  --all                   Install agent files, templates, and selected workflows (default)"
    echo "  -f, --force             Overwrite existing files without prompting"
    echo "  -h, --help              Show this help message"
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
    echo "  COMPLIANCE.md                     (Compliance tracker for Tier 1 & 2 projects)"
    echo ""
    echo "Starter workflows (-w|--workflow):"
    echo "  python, java, typescript, vdd"
    echo ""
    echo "Public repo defense (-g|--guard):"
    echo "  .github/workflows/repo-guard.yml  (Tamper detection & alerts for external fork PRs)"
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
        --tier) PROJECT_TIER="$2"; shift 2 ;;
        -w|--workflow|--workflows) WORKFLOW_TYPE="$2"; shift 2 ;;
        -g|--guard) INSTALL_GUARD=true; shift ;;
        --all) INSTALL_AGENTS=true; INSTALL_TEMPLATES=true; shift ;;
        -f|--force) FORCE=true; shift ;;
        -h|--help) usage ;;
        -*) echo "Unknown option: $1"; echo ""; usage ;;
        *) TARGET="$1"; shift ;;
    esac
done

# Default to --all if neither --agents nor --templates was explicitly selected
if [ "$INSTALL_AGENTS" = false ] && [ "$INSTALL_TEMPLATES" = false ] && [ -z "$WORKFLOW_TYPE" ] && [ "$INSTALL_GUARD" = false ]; then
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

if [ -n "$PROJECT_TIER" ]; then
    case $PROJECT_TIER in
        1)
            echo "--> Project Tier: 🧪 Tier 1 — Prototype / Experiment"
            copy_file "$TEMPLATES_DIR/COMPLIANCE_TEMPLATE.md" "$TARGET/COMPLIANCE.md"
            ;;
        2)
            echo "--> Project Tier: 🔧 Tier 2 — Personal Tool"
            copy_file "$TEMPLATES_DIR/COMPLIANCE_TEMPLATE.md" "$TARGET/COMPLIANCE.md"
            ;;
        3)
            echo "--> Project Tier: 🏢 Tier 3 — Internal / Team Service"
            echo "    Note: Track compliance using GitHub Issues with label 'constitution' and a Milestone."
            ;;
        4)
            echo "--> Project Tier: 🚀 Tier 4 — Production / Public Service"
            echo "    Note: Track compliance using GitHub Issues with label 'constitution' and a Milestone."
            ;;
        *)
            echo "Warning: Invalid tier '$PROJECT_TIER'. Choose from 1, 2, 3, 4."
            ;;
    esac
    echo ""
fi

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
    if [ "$PROJECT_TIER" = "1" ] || [ "$PROJECT_TIER" = "2" ] || [ -z "$PROJECT_TIER" ]; then
        copy_file "$TEMPLATES_DIR/COMPLIANCE_TEMPLATE.md" "$TARGET/COMPLIANCE.md"
    fi
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

if [ "$INSTALL_GUARD" = true ]; then
    echo "--> Installing Repo Guard & Tamper Defense Workflow..."
    copy_file "$TEMPLATES_DIR/workflows/repo-guard.yml" "$TARGET/.github/workflows/repo-guard.yml"
    echo "    Repo Guard monitors PRs from external forks and blocks workflow modifications."
    echo ""
fi

echo "Done. Remember to:"
echo "  1. Declare your project tier in README.md (e.g. ## Constitution Compliance)"
echo "  2. Configure branch protection for 'main' and 'dev' (see Constitution Section 11)"
echo "  3. Commit the new files to your repository"
echo "  4. Optionally copy CONSTITUTION.md to your repo root for offline agent access"

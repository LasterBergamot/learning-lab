#!/usr/bin/env bash
# Merge the latest changes from the template this repo was created from.
#
# The template's URL is in .github/template-source. A repo made with "Use this template" shares no
# history with the template, so the first run records a baseline: the template commit whose files
# match this repo's first commit, merged with "-s ours" (history only, no file changes). Every later
# run is a normal merge, so only what changed in the template since the last sync comes in.
#
# Usage: bash scripts/template-sync.sh [--baseline <template-commit>]
#   --baseline  the template commit this repo started from, when it can't be found automatically
#               (for example a repo that wasn't made with "Use this template")
#
# Runs the same on Linux and in Git Bash on Windows. It merges into the current branch and never
# pushes. Merge the resulting PR with a merge commit, not a squash, or the next sync repeats work.
set -euo pipefail

baseline=''
while [ $# -gt 0 ]; do
  case "$1" in
    --baseline) baseline=${2:?--baseline needs a commit}; shift 2 ;;
    -h|--help) sed -n '2,14p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 2 ;;
  esac
done

cd "$(git rev-parse --show-toplevel)"

src_file=.github/template-source
[ -f "$src_file" ] || { echo "No $src_file: this repo doesn't name its template." >&2; exit 1; }
url=$(grep -v -e '^#' -e '^[[:space:]]*$' "$src_file" | head -n 1 | tr -d '[:space:]')
[ -n "$url" ] || { echo "$src_file has no URL." >&2; exit 1; }

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "Uncommitted changes: commit or stash them first." >&2
  exit 1
fi

remote=template
if git remote get-url "$remote" >/dev/null 2>&1; then
  git remote set-url "$remote" "$url"
else
  git remote add "$remote" "$url"
fi
git fetch --quiet "$remote" main
upstream="$remote/main"
short() { git rev-parse --short "$1"; }

if git merge-base --is-ancestor "$upstream" HEAD; then
  echo "Up to date with the template ($(short "$upstream"))."
  exit 0
fi

if ! git merge-base HEAD "$upstream" >/dev/null; then
  if [ -z "$baseline" ]; then
    # "Use this template" copies the template's files into a fresh first commit, so the trees match.
    root=$(git rev-list --max-parents=0 HEAD | tail -n 1)
    root_tree=$(git rev-parse "$root^{tree}")
    baseline=$(git log --format='%H %T' "$upstream" | awk -v t="$root_tree" '$2 == t { print $1; exit }')
  fi
  if [ -z "$baseline" ]; then
    echo "No shared history with the template, and no template commit matches this repo's first commit." >&2
    echo "Find the template commit you started from, then run:" >&2
    echo "  bash scripts/template-sync.sh --baseline <commit>" >&2
    exit 1
  fi
  git merge-base --is-ancestor "$baseline" "$upstream" || {
    echo "$baseline is not a commit on the template's main branch." >&2; exit 1; }
  git merge --quiet -s ours --allow-unrelated-histories --no-edit \
    -m "Record the template baseline ($(short "$baseline"))" "$baseline"
  echo "Recorded the template baseline: $(short "$baseline")."
fi

if git merge --no-ff --no-edit -m "Merge template updates ($(short "$upstream"))" "$upstream"; then
  echo "Merged the template up to $(short "$upstream")."
  echo "Check the result, then push. If it goes through a PR, merge it with a merge commit, not a squash."
else
  echo >&2
  echo "Conflicts in:" >&2
  git diff --name-only --diff-filter=U | sed 's/^/  /' >&2
  echo "Resolve them, run 'git add' on each file, then 'git commit'. 'git merge --abort' undoes it." >&2
  exit 1
fi

#!/usr/bin/env bash
set -euo pipefail

skill_home="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
targets=(
  "$HOME/.codex/skills"
  "$HOME/.claude/skills"
  "$HOME/.agents/skills"
)

for target in "${targets[@]}"; do
  mkdir -p "$target"
done

for skill_dir in "$skill_home"/*; do
  [[ -d "$skill_dir" ]] || continue
  [[ -f "$skill_dir/SKILL.md" ]] || continue

  skill_name="$(basename "$skill_dir")"
  for target in "${targets[@]}"; do
    dest="$target/$skill_name"
    if [[ -L "$dest" ]]; then
      unlink "$dest"
    elif [[ -e "$dest" ]]; then
      echo "skip $dest: exists and is not a symlink" >&2
      continue
    fi
    ln -s "$skill_dir" "$dest"
    echo "linked $dest -> $skill_dir"
  done
done

#!/usr/bin/env bash
set -euo pipefail

TARGET="${DOUYIN_TOOL_DIR:-$HOME/.agent-reach/tools/Douyin_TikTok_Download_API}"

echo "Douyin tool target: $TARGET"

if [ ! -d "$TARGET" ]; then
  echo "status=missing"
  echo "Run: bash /Users/zhw/.ai-skills/douyin-growth-research/scripts/setup_tool.sh"
  exit 0
fi

if [ -d "$TARGET/.git" ]; then
  echo "status=installed"
  echo "remote=$(git -C "$TARGET" remote get-url origin 2>/dev/null || true)"
  echo "commit=$(git -C "$TARGET" rev-parse --short HEAD 2>/dev/null || true)"
else
  echo "status=installed_non_git"
fi

[ -f "$TARGET/README.md" ] && echo "readme=ok" || echo "readme=missing"
[ -f "$TARGET/config.yaml" ] && echo "config=ok" || echo "config=missing"
[ -f "$TARGET/requirements.txt" ] && echo "requirements=ok" || echo "requirements=missing"

if command -v docker >/dev/null 2>&1; then
  echo "docker=available"
else
  echo "docker=missing"
fi

if command -v python3 >/dev/null 2>&1; then
  echo "python3=$(python3 --version 2>&1)"
else
  echo "python3=missing"
fi

echo "cookie_policy=local_only_never_commit"

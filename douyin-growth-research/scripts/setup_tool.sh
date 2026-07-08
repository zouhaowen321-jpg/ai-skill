#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/Evil0ctal/Douyin_TikTok_Download_API.git"
TARGET="${DOUYIN_TOOL_DIR:-$HOME/.agent-reach/tools/Douyin_TikTok_Download_API}"

mkdir -p "$(dirname "$TARGET")"

if [ -d "$TARGET/.git" ]; then
  echo "Updating existing tool at: $TARGET"
  git -C "$TARGET" pull --ff-only
else
  echo "Cloning tool to: $TARGET"
  rm -rf "$TARGET"
  git clone --depth 1 "$REPO_URL" "$TARGET"
fi

echo "Tool path: $TARGET"
echo "Commit: $(git -C "$TARGET" rev-parse --short HEAD)"

if [ -f "$TARGET/config.yaml" ]; then
  echo "Config exists: $TARGET/config.yaml"
else
  echo "Warning: config.yaml not found."
fi

echo "Do not commit cookies or account tokens. Keep them local only."

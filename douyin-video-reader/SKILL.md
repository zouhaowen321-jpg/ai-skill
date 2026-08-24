---
name: douyin-video-reader
description: Use when the user gives one or more specific Douyin/抖音 video links (or IDs) and wants the content read, extracted, or summarized into Markdown for an agent or knowledge base to consume — caption/文案, spoken transcript when the caption isn't enough, author, publish time, engagement stats, and top comments. Reuses the local Evil0ctal/Douyin_TikTok_Download_API tool at ~/.agent-reach/tools/Douyin_TikTok_Download_API (same install douyin-growth-research uses) but calls its info-only route — never downloads or keeps a video/audio file. Not for downloading/saving videos, bulk account scraping, hashtag/competitor research, or growth strategy — use douyin-growth-research for that.
---

# Douyin Video Reader

Turn specific Douyin/抖音 video links into clean Markdown that an agent can read — text and metadata only, no video files kept anywhere.

## Operating Rules

1. Output is text/Markdown only. Never save, download, or leave a video or audio file anywhere in the workspace or repo. If the API response includes a play/download URL, keep it only as a citation string in the frontmatter — never fetch the binary.
2. Call the local tool's info/data route only (e.g. `/api/hybrid/video_data` — check the running instance's `/docs` Swagger page for the exact current path/port; it can change across versions). Never call a download/save route.
3. If the caption/文案 already carries the full message (common for text-heavy Douyin posts), use it directly as the content — don't run speech-to-text.
4. If the spoken content clearly isn't in the caption (talking-head/vlog style) and no speech-to-text path is available, say so plainly in `## Transcript` instead of guessing or fabricating what was said.
5. Never request, print, save, or commit Douyin cookies.
6. Same platform boundaries as `douyin-growth-research`: no bypassing login/CAPTCHA/rate limits, no scraping private content, no automating likes/comments/follows/publishing.

## Quick Checks

Run from this skill's own directory:

```bash
bash scripts/check_tool.sh
```

If missing or stale:

```bash
bash scripts/setup_tool.sh
```

This shares the same local install as `douyin-growth-research` (`~/.agent-reach/tools/Douyin_TikTok_Download_API`) — running either skill's setup is enough for both.

## Workflow

1. Collect the target link(s) from the user — one video or a batch.
2. Run `scripts/check_tool.sh`. If missing, run `scripts/setup_tool.sh`.
3. Start the tool per its own README if it isn't already running. Use its info-serving mode and confirm the current route/port from its `/docs` page — don't assume a hardcoded port.
4. For each link, call the info-only route (e.g. `GET /api/hybrid/video_data?url=<link>&minimal=false`) — never a download route.
5. Map the response onto the template in `references/markdown-schema.md`:
   - `Caption` = caption/文案 verbatim when it carries the full message.
   - `Transcript` = only filled in when speech-to-text actually ran this session; otherwise state plainly it wasn't generated.
   - `Top Comments` = only comments the API actually returned; never invent any.
6. Write one Markdown file per video (default `<video_id>.md` in the directory the user asked for), or print the block inline if they just want a quick read. For a batch, also print a one-line index (link → title → file path).
7. If a link fails to resolve (private, deleted, region-locked, needs login), say so for that link and keep going with the rest — don't stop the whole batch.

## Output Contract

Single video: return the Markdown block (frontmatter + sections) in chat, or write it to the requested path.

Batch: an index list first, then each video's Markdown.

If the user asked for analysis (not just extraction), add a `## Summary` (2–4 sentences: hook, topic, why the caption/transcript supports that read) — grounded only in the fetched content, no speculation beyond it.

Read `references/markdown-schema.md` for the exact frontmatter fields and a worked example. Read `references/safety-and-usage.md` for the no-download boundary and prompt examples.

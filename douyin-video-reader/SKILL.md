---
name: douyin-video-reader
description: Use when the user gives one or more specific Douyin/抖音 video links (or IDs) and wants the content read, extracted, or summarized into Markdown for an agent or knowledge base to consume — caption/文案, the platform's chapter summary, on-screen text and burned-in subtitles, the step-by-step operations and prompts shown in the video, author, publish time, engagement stats, and visible comments. Opens the public video page in a normal browser and reads only what the page itself loads, plus video frames viewed as screenshots — never downloads or keeps a video/audio file, never forges signatures, no speech-to-text. Not for downloading/saving videos, bulk account scraping, hashtag/competitor research, or growth strategy — use douyin-growth-research for that.
---

# Douyin Video Reader

Turn specific Douyin/抖音 video links into clean Markdown that an agent can read — caption, chapters, on-screen text, subtitles and the operations shown in the video. Text only, no video files kept anywhere.

## Operating Rules

1. Output is text/Markdown only. Never save, download, or leave a video or audio file anywhere. Frames are drawn inside the page and read from screenshots in the conversation — never save frames as image files in the workspace or repo.
2. Read only what the video page itself loads: its own `aweme/detail` response and the rendered page. Don't replay or re-sign API requests, don't generate signatures, don't use stealth/anti-detection browsers or flags.
3. No speech-to-text. Anything only spoken aloud and never shown on screen is out of scope — say so plainly in the output instead of guessing.
4. Never request, print, save, or commit Douyin cookies. Use the browser as it is; never log in or out on the user's behalf.
5. If a CAPTCHA, verification page, or login wall hides the content, stop for that link and ask the user to handle it themselves in the browser. Never solve or bypass it. A login prompt that doesn't hide the content can be closed with its ✕.
6. Same platform boundaries as `douyin-growth-research`: no scraping private content, no automating likes/comments/follows/publishing.

## Browser

- Default: Claude Code's built-in Browser pane (`mcp__Claude_Browser__*`). Use another normal browser tool only if that one is unavailable.
- The built-in browser may already be signed in to a Douyin account; reading through it is recorded under that account. Mention this once if it matters to the user.
- The old local API path (`scripts/check_tool.sh`, Evil0ctal v4 on port 8080) stopped working in 2026-11: Douyin now requires `uifid` + `x-secsdk-web-signature`. Don't use it, and don't run `scripts/setup_tool.sh` — it would `git pull` or `rm -rf` the tool folder that `douyin-growth-research` also uses.

## Workflow

1. Collect the target link(s) from the user — one video or a batch. `v.douyin.com` short links redirect to `www.douyin.com/video/<aweme_id>`.
2. Open the link in the browser and wait ~3 s. If verification or a login wall covers the content, follow Rule 5.
3. Metadata: read the page's own `aweme/detail` response — caption, author, publish time, duration, chapter summary, subtitles if any (`references/browser-extraction.md` §1).
4. Stats and visible comments from the page (§2). Comments = only what is rendered; don't scroll-scrape more unless the user asks.
5. Subtitles: if `video.subtitle_infos` or the video's text tracks have content, use them. Otherwise burned-in subtitles are read from frames in step 6.
6. On-screen text, subtitles and steps — the frame reader (§3). Do this when the user wants the video's content, steps or prompts, or when the caption and chapters don't carry them; skip it for a quick metadata-only read.
   - Sample the chapter timestamps first, then every 2 s, 4 frames per screenshot; crop in on small text.
   - Copy prompts, commands, menu paths and settings verbatim only when every character is legible. Mark unreadable parts `[看不清]`. Never fill gaps from guesswork.
   - Turn what the frames show into numbered steps; each step says what to do and where, with any prompt in a code block.
   - Run `__framesOff()` when done.
7. Map everything onto the template in `references/markdown-schema.md`.
8. Write one Markdown file per video (default `<video_id>.md` in the directory the user asked for), or print the block inline if they just want a quick read. For a batch, also print a one-line index (link → title → file path).
9. If a link fails (private, deleted, region-locked, blocked by verification), say so for that link and keep going with the rest — don't stop the whole batch.

## Output Contract

Single video: return the Markdown block (frontmatter + sections) in chat, or write it to the requested path.

Batch: an index list first, then each video's Markdown.

If the user asked for analysis (not just extraction), add a `## Summary` (2–4 sentences: hook, topic, why the content supports that read) — grounded only in what was read, no speculation beyond it.

Read `references/browser-extraction.md` for the tested browser snippets, `references/markdown-schema.md` for the frontmatter fields and a worked example, and `references/safety-and-usage.md` for the boundaries and prompt examples.

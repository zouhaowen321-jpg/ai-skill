# Safety And Usage

## Allowed Use

- Open a specific public Douyin video page in a normal browser and read its caption, metadata, chapter summary, subtitles and visible engagement stats from what the page itself loads, then turn them into Markdown for the user's own agent or knowledge base.
- Read on-screen text, burned-in subtitles and the operations shown in the video by drawing frames inside the page and viewing them as screenshots — the text is the deliverable, never the frames.
- Read the public comments the page shows, for context.
- Batch-read a list of links the user already has. For discovering new links via search/scraping, pair with `agent-reach` or `douyin-growth-research` instead.

## Disallowed Use

- Do not save, download, export, or commit a video or audio file to disk, the workspace, or GitHub — not even temporarily.
- Do not save frames or screenshots as image files in the workspace or repo, and don't use a screenshot tool's save-to-file option for them.
- Do not run speech-to-text.
- Do not replay or re-sign Douyin API requests, generate signatures (`a_bogus`, `X-Bogus`, `x-secsdk-web-signature`, …), or use stealth/anti-detection browsers or launch flags.
- Do not bypass CAPTCHA, login gates, anti-bot systems, rate limits, paywalls, or private-account restrictions. When one blocks the content, stop and let the user handle it themselves.
- Do not log in or out of Douyin on the user's behalf.
- Do not automate likes, comments, follows, DMs, reposts, or publishing.
- Do not scrape private user information.
- Do not fabricate on-screen text, prompts, steps, or comments — mark unreadable text `[看不清]` and say what wasn't available.
- Do not commit cookies, tokens, config files with secrets, or scraped personal data to GitHub.

## Old Local Tool (no longer used)

This skill used to call the local Evil0ctal/Douyin_TikTok_Download_API v4 at `~/.agent-reach/tools/Douyin_TikTok_Download_API` (port 8080, `/api/hybrid/video_data`). Since 2026-11 Douyin rejects its requests (`Uifid Not Found`, then `Signature Not Found`), so the browser path replaced it.

The folder is still shared with `douyin-growth-research`. Don't run `scripts/setup_tool.sh` against it: upstream `main` is now v5, so the script's `git pull` or `rm -rf` + clone would replace v4.

## Prompt Examples

```text
用 douyin-video-reader 读一下这条抖音视频,转成 markdown 给我的 agent 用:<链接>
```

```text
用 douyin-video-reader 把这条视频里每一步的操作和提示词整理出来:<链接>
```

```text
用 douyin-video-reader 把这 5 条抖音链接的文案和评论整理成 markdown,不用看画面。
```

```text
用 douyin-video-reader 读这条视频并分析一下它的钩子和结构。
```

# Safety And Usage

## Allowed Use

- Fetch a specific Douyin video's public caption, metadata, and visible engagement stats via the local tool's info route, and turn them into Markdown for the user's own agent or knowledge base.
- Run speech-to-text on a video's audio only as an ephemeral step when the caption doesn't carry the spoken content, then discard the temp media immediately — the transcript text is the deliverable, never the media file.
- Read public top comments the API returns, for context.
- Batch-read a list of links the user already has. For discovering new links via search/scraping, pair with `agent-reach` or `douyin-growth-research` instead.

## Disallowed Use

- Do not save, download, export, or commit a video or audio file to disk, the workspace, or GitHub — not even temporarily beyond what a transcription step needs, and never as a task deliverable.
- Do not call the tool's download/save routes — info routes only.
- Do not bypass CAPTCHA, login gates, anti-bot systems, rate limits, paywalls, or private-account restrictions.
- Do not automate likes, comments, follows, DMs, reposts, or publishing.
- Do not scrape private user information.
- Do not fabricate a transcript or comments when the API didn't return them — state they're unavailable instead.
- Do not commit cookies, tokens, config files with secrets, or scraped personal data to GitHub.

## Local Tool

Default path (override with `DOUYIN_TOOL_DIR`):

```text
~/.agent-reach/tools/Douyin_TikTok_Download_API
```

Source repository:

```text
https://github.com/Evil0ctal/Douyin_TikTok_Download_API
```

Shared with `douyin-growth-research` — one install serves both skills. This skill only ever calls its info/data route (e.g. `/api/hybrid/video_data`); check the running instance's `/docs` page for the exact current path. The upstream project may need a Douyin Cookie in `config.yaml` for some fields — keep that file local, never commit it. If a task needs it and it isn't configured, report the blocker and ask the user to configure it locally.

## Prompt Examples

```text
用 douyin-video-reader 读一下这条抖音视频,转成 markdown 给我的 agent 用:<链接>
```

```text
用 douyin-video-reader 把这 5 条抖音链接的文案和评论整理成 markdown,不要下载视频。
```

```text
用 douyin-video-reader 读这条视频并分析一下它的钩子和结构。
```

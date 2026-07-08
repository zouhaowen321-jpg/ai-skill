---
name: douyin-growth-research
description: Use when the user asks to research or analyze Douyin/抖音, TikTok, viral videos, competitor accounts, hashtags, comments, video links, or Douyin account growth strategy. Integrates the local Evil0ctal/Douyin_TikTok_Download_API tool at ~/.agent-reach/tools/Douyin_TikTok_Download_API when available. Not for bypassing login, CAPTCHA, rate limits, mass scraping, auto-liking/commenting/following, or reposting copyrighted content.
---

# Douyin Growth Research

Use this skill for Douyin/TikTok public-content research, viral-video teardown, competitor account analysis, topic mining, comment mining, and account strategy.

## Operating Rules

1. Treat `agent-reach` as the general internet router. Use this skill only for Douyin/TikTok-specific collection or analysis.
2. Use the local tool when installed:
   `/Users/zhw/.agent-reach/tools/Douyin_TikTok_Download_API`
3. Never request, print, save, or commit Douyin cookies in chat or GitHub.
4. Do not bypass login, CAPTCHA, anti-bot, rate limits, paywalls, private content, or platform restrictions.
5. Do not automate likes, comments, follows, DMs, reposts, or publishing.
6. Do not download and re-upload other creators' videos as content. Use data for research and original strategy.

## Quick Checks

Run:

```bash
bash /Users/zhw/.ai-skills/douyin-growth-research/scripts/check_tool.sh
```

If the tool is missing or stale, run:

```bash
bash /Users/zhw/.ai-skills/douyin-growth-research/scripts/setup_tool.sh
```

## Workflow

1. Define the research target: keyword, account, hashtag, video links, niche, time window, and output format.
2. Check the local tool with `scripts/check_tool.sh`.
3. If Douyin data requires browser login/Cookie, keep it local in the tool's `config.yaml`; do not expose the cookie.
4. Collect only public-content fields needed for analysis:
   - video URL
   - author/account
   - title/caption
   - hashtags
   - publish time
   - like/comment/share/favorite counts when visible
   - top public comments when visible
   - cover/first-frame observations
5. Use `agent-reach` for complementary research on web, Xiaohongshu, Bilibili, Reddit, X, or general search.
6. Store outputs in a table when the task is recurring or operational.
7. Analyze the content with this structure:
   - hook/opening
   - topic angle
   - audience pain point
   - credibility/proof
   - visual packaging
   - pacing/script pattern
   - comment demand
   - repeatable format
   - how to adapt it into the user's original Douyin/Xiaohongshu content

## Output Contract

For viral-video or competitor analysis, return:

1. Source scope and collection method.
2. A table of videos/accounts with core metrics.
3. Viral pattern summary.
4. Repeatable content templates.
5. Original topic ideas for the user's account.
6. Risks: copyright, overfitting, platform limits, weak data, or stale metrics.

For account operation planning, return:

1. Positioning.
2. Content pillars.
3. 10-30 topic ideas.
4. Script or storyboard examples.
5. Posting and review cadence.
6. Metrics to track in Google Sheets.

Read `references/safety-and-usage.md` for safety boundaries, table schema, and prompt examples when the task involves automation, account strategy, or data storage.

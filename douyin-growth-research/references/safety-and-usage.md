# Safety And Usage

## Allowed Use

- Analyze public Douyin/TikTok videos, accounts, captions, hashtags, and visible engagement metrics.
- Break down viral video structure for original content strategy.
- Mine public comments for audience pain points and topic ideas.
- Build Google Sheets for topic banks, competitor tracking, and weekly content review.
- Use `agent-reach` for complementary research on Xiaohongshu, Bilibili, web search, Reddit, X, Instagram, and Facebook.

## Disallowed Use

- Do not bypass CAPTCHA, login gates, anti-bot systems, rate limits, paywalls, or private account restrictions.
- Do not automate likes, comments, follows, DMs, reposts, or publishing.
- Do not scrape private user information.
- Do not download and re-upload another creator's video as the user's own content.
- Do not commit cookies, tokens, config files with secrets, browser profiles, or scraped personal data to GitHub.

## Local Tool

Default path:

```text
/Users/zhw/.agent-reach/tools/Douyin_TikTok_Download_API
```

Source repository:

```text
https://github.com/Evil0ctal/Douyin_TikTok_Download_API
```

The upstream project may require local Douyin Cookie configuration in `config.yaml`. Keep that file local if it contains secrets. If a task requires login/Cookie and it is not configured, report the blocker and ask the user to configure it locally.

## Suggested Google Sheets Columns

For viral-video research:

```text
date_collected
platform
keyword_or_account
video_url
author
caption
hashtags
publish_time
likes
comments
shares
favorites
hook
topic_angle
audience_pain_point
format_pattern
top_comment_insight
adaptation_idea
risk_note
source_status
```

For account operations:

```text
date
content_pillar
topic
target_audience
hook
script_outline
visual_plan
caption
hashtags
status
publish_link
likes
comments
shares
followers_delta
review_note
next_action
```

## Prompt Examples

```text
Use douyin-growth-research to analyze 20 public Douyin videos about 留学生求职 and summarize repeatable hooks.
```

```text
Use douyin-growth-research to review this Douyin account and create a 30-day topic bank for my personal account.
```

```text
Use douyin-growth-research plus agent-reach to compare Douyin, Xiaohongshu, and Bilibili content angles for 海外求职.
```

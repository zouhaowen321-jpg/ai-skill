# Markdown Output Schema

One video = one Markdown file (or one inline block). Frontmatter is flat YAML so a naive line-based parser can read it; the body uses fixed headings so an agent can grep by section.

## Template

```markdown
---
source: douyin
url: "<share link exactly as given>"
video_id: "<aweme_id from the API response>"
author_name: "<nickname>"
author_id: "<sec_uid or unique_id>"
publish_time: "<as returned by the API>"
duration_sec: <int, omit if unknown>
likes: <int, omit if unknown>
comments: <int, omit if unknown>
shares: <int, omit if unknown>
collects: <int, omit if unknown>
hashtags: ["tag1", "tag2"]
fetched_at: "<ISO 8601, when this file was generated>"
---

# <first ~20 words of the caption, or the platform's title field>

## Caption
<full caption/文案 text, verbatim>

## Transcript
<speech-to-text transcript, only if actually generated this run — otherwise:>
Not generated for this run — caption above was used as the content.

## Top Comments
- "<comment text>" — <commenter name>, <like_count> likes
- ...
(omit this section entirely if the API returned no comments)

## Summary
<2-4 sentences, only when the task asked for analysis>
```

## Field Notes

- Exact JSON field names (`video_id`, `author_id`, stat names, etc.) vary by tool version — confirm against the running instance's `/docs` page rather than assuming this doc's names match 1:1.
- `duration_sec`/`likes`/`comments`/`shares`/`collects`: omit the key entirely rather than writing `null` or `0` when the API didn't return it — a missing key is easier for an agent to branch on than a fake zero.
- `hashtags`: pull from the caption's `#tag` mentions or the API's dedicated hashtag field if present; de-duplicate.
- Batch runs also get an index block ahead of the individual files/blocks:

```markdown
## Index
1. [<short title>](<video_id>.md) — <url>
2. ...
```

## Worked Example

```markdown
---
source: douyin
url: "https://v.douyin.com/xxxxxxx/"
video_id: "7123456789012345678"
author_name: "示例账号"
author_id: "MS4wLjABAAAA..."
publish_time: "2026-06-01T10:00:00+08:00"
duration_sec: 47
likes: 12000
comments: 340
shares: 210
collects: 980
hashtags: ["留学生求职", "海外职场"]
fetched_at: "2026-08-24T09:00:00Z"
---

# 留学生求职被拒的3个真实原因

## Caption
留学生求职被拒真的不是因为学历不够...(原文全文)

## Transcript
Not generated for this run — caption above was used as the content.

## Top Comments
- "说得对,我上次就是卡在第二点" — 用户A, 210 likes
- "求补充一个案例" — 用户B, 88 likes
```

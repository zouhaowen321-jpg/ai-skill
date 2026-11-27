# Markdown Output Schema

One video = one Markdown file (or one inline block). Frontmatter is flat YAML so a naive line-based parser can read it; the body uses fixed headings so an agent can grep by section.

## Template

```markdown
---
source: douyin
url: "<share link exactly as given>"
video_id: "<aweme_id>"
author_name: "<nickname>"
author_id: "<sec_uid>"
publish_time: "<ISO 8601, Asia/Shanghai>"
duration_sec: <int, omit if unknown>
likes: <int, omit if unknown>
comments: <int, omit if unknown>
shares: <int, omit if unknown>
collects: <int, omit if unknown>
hashtags: ["tag1", "tag2"]
frames_read: <true | false>
fetched_at: "<ISO 8601, when this file was generated>"
---

# <first ~20 words of the caption, or the platform's title field>

## Caption
<full caption/文案 text, verbatim>

## Chapters
<platform-generated chapter summary, verbatim; omit this section if the video has none>
<chapter_abstract>
- 00:11 <chapter title> — <chapter detail>
- ...

## On-screen Text & Subtitles
- [00:14] <text as shown on screen, verbatim>
- [00:20] "<subtitle line>"
- ...
<if frames were not read this run, write instead:>
Not read for this run — frame reading was skipped.
> Spoken audio is not transcribed. Anything only said aloud and never shown on screen is not in this file.

## Steps
1. <what to do, where> (00:11–00:26)
   ```text
   <prompt / command / setting, verbatim>
   ```
2. ...
(omit this section if the video shows no operations)

## Top Comments
- "<comment text>" — <commenter name>, <like_count> likes
- ...
(omit this section entirely if the page showed no comments)

## Summary
<2-4 sentences, only when the task asked for analysis>
```

## Field Notes

- Field sources: see the table in `browser-extraction.md` §1 (`aweme_detail` from the page's own response). Stats can also come from the page (§2).
- `duration_sec`/`likes`/`comments`/`shares`/`collects`: omit the key entirely rather than writing `null` or `0` when the value wasn't available — a missing key is easier for an agent to branch on than a fake zero. Convert `4.3万` to `43000` and note that it is rounded if precision matters.
- `hashtags`: pull from the caption's `#tag` mentions; de-duplicate.
- `frames_read`: `true` only if the frame reader actually ran this time.
- On-screen text: record each piece of text once, at the first timestamp it appears. Use `[看不清]` for characters that can't be read; never fill them in.
- Steps: build them only from what the frames and chapters show. If a step's prompt is cut off or partly unreadable, say so in that step.
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
duration_sec: 92
likes: 12000
comments: 340
shares: 210
collects: 980
hashtags: ["AI工具", "效率"]
frames_read: true
fetched_at: "2026-08-24T09:00:00Z"
---

# 新装的编辑器先做这3步设置

## Caption
新装的编辑器先做这3步设置 #AI工具 #效率

## Chapters
介绍新编辑器装好后的三项基础设置。
- 00:05 切换中文 — 用一条提示词把界面改成中文。
- 00:31 打开自动保存 — 在设置里开启自动保存。

## On-screen Text & Subtitles
- [00:05] 第一步：切换中文
- [00:08] "先把这条提示词发给它"
- [00:31] 第二步：打开自动保存
> Spoken audio is not transcribed. Anything only said aloud and never shown on screen is not in this file.

## Steps
1. 在对话框发送提示词，把界面切换成中文（00:05–00:30）
   ```text
   请把界面语言改成简体中文
   ```
2. 打开 设置 → 文件 → 自动保存，选「延迟后」（00:31–00:50）

## Top Comments
- "第二步找了半天，原来在这" — 用户A, 210 likes
```

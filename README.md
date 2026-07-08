# AI Skills

Shared skill package for Codex and Claude Code.

## Layout

Each skill lives in its own folder:

```text
agent-reach/
  SKILL.md
  references/
design-taste-frontend/
  SKILL.md
redesign-existing-projects/
  SKILL.md
image-to-code/
  SKILL.md
full-output-enforcement/
  SKILL.md
douyin-growth-research/
  SKILL.md
  scripts/
  references/
```

## Local setup

Clone this repository to `~/.ai-skills`, then run:

```bash
~/.ai-skills/scripts/link-local-skills.sh
```

The script links each skill into:

```text
~/.codex/skills
~/.claude/skills
~/.agents/skills
```

Add future skills as new folders with a `SKILL.md`, commit them, push to GitHub,
then pull and rerun the link script on any machine that should use them.

## Current Skills

| Skill | Use |
| --- | --- |
| `agent-reach` | Research the web, links, GitHub, social platforms, videos, and public discussions. |
| `design-taste-frontend` | Build landing pages, portfolios, and visual frontend work without generic AI-looking design. |
| `redesign-existing-projects` | Audit and improve an existing website or app UI without rewriting from scratch. |
| `image-to-code` | Generate visual references first, analyze them, then implement a matching frontend. |
| `full-output-enforcement` | Force complete outputs when an agent might otherwise truncate or use placeholders. |
| `douyin-growth-research` | Research Douyin/TikTok public content, competitor accounts, viral videos, and account strategy safely. |

Taste Skill imports come from `Leonxlnx/taste-skill`; see `THIRD_PARTY_NOTICES.md`.

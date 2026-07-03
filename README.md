# AI Skills

Shared skill package for Codex and Claude Code.

## Layout

Each skill lives in its own folder:

```text
agent-reach/
  SKILL.md
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

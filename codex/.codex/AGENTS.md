# Personal Codex Guidance

These instructions apply across the laptop. Project `AGENTS.md` files are more specific and should provide repo-specific build, test, and workflow details.

## Working Agreements

- Keep changes surgical and avoid unrelated refactors.
- If repo state changes unexpectedly, assume it came from me and work around it rather than reverting it.
- Prefer `rg`/`rg --files` for search, direct file reads for context, and `apply_patch` for manual edits.
- Use subagents only when I explicitly ask for delegation or parallel agent work.

## Laptop Layout

- Dotfiles live in `~/.dotfiles`; keep durable Codex configuration there.
- Live Codex files in `~/.codex` should be symlinks into `~/.dotfiles/codex/.codex` when practical.
- Code repositories live in `~/code`.

## Tools

- Prefer Codex plugins/apps and `tool_search` for GitHub, browser, Linear, Notion, Figma, Slack, Gmail, Google Drive, and Google Calendar.
- Use `browser-use` for browser automation.
- Treat external tool sessions as short-lived; leave enough context in the transcript for the next session.

@/Users/kyang/.codex/RTK.md

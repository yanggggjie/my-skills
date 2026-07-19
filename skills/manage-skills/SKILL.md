---
name: manage-skills
description: Manage agent skills with the skills CLI. Use when installing, updating, creating, listing, or removing skills; when the user mentions npx skills, skills add/update/init, global skill install, plugin.json, or a skills/ repo layout.
---

# Manage Skills

**Single tool:** the Skills CLI (`npx skills` / `skills`). Do not invent parallel install paths.

**Canonical layout** (every skill lives in a skills repo):

```
<repo>/
  .claude-plugin/plugin.json
  skills/
    <skill-name>/
      SKILL.md
      …optional companions (scripts, GLOSSARY.md, …)
```

Personal skills repo: `yanggggjie/my-skills` (local: wherever that clone lives).

## Install (global, symlink)

Always global. Always symlink (CLI default — **never** pass `--copy`).

```bash
npx skills add <owner/repo> -g -y
npx skills add <owner/repo> -g -y -s <skill-name>   # one skill
npx skills add <local-path-to-skills-repo> -g -y    # from a clone
```

Completion: `npx skills ls -g` shows the skill; its agent dir entry is a symlink into `~/.agents/skills/<name>` (or the universal store), not a copied tree.

## Update

```bash
npx skills update -g              # all global
npx skills update <skill-name> -g # one
```

Completion: command exits 0; skill content matches upstream (or reported up-to-date).

## Create

1. **Load** `writing-great-skills` and follow it for frontmatter, description, steps vs reference, pruning.
2. **Pick the skills repo** (default `yanggggjie/my-skills`). Skill path must be `skills/<skill-name>/SKILL.md` — not repo root, not a flat `SKILL.md` at top level.
3. **Write** the skill directory + `SKILL.md` (and any disclosed companions).
4. **Register** in `.claude-plugin/plugin.json`: set `name` (plugin id, kebab-case) and append `"./skills/<skill-name>"` to `skills`. Create the file if missing:

```json
{
  "name": "my-skills",
  "version": "1.0.0",
  "description": "Personal agent skills.",
  "skills": [
    "./skills/repo-cache",
    "./skills/manage-skills"
  ]
}
```

5. **Install globally** (symlink): `npx skills add <that-repo-or-path> -g -y -s <skill-name>` (or without `-s` to refresh the whole plugin).
6. **Commit/push** when the user wants the GitHub source to carry `plugin.json` (local `skills add` does not reliably persist `pluginName` for GitHub-sourced lock entries).

Completion: skill exists under `skills/<skill-name>/SKILL.md`, is listed in `plugin.json`, and appears under the plugin group in `npx skills ls -g` (e.g. **My Skills** when `name` is `my-skills`).

## List / remove

```bash
npx skills ls -g
npx skills remove <skill-name> -g -y
```

## Discover (optional)

```bash
npx skills find <query>
```

Prefer installing found packages with the Install rules above. For deeper discovery UX, `find-skills` may help — still install via `npx skills add … -g`.

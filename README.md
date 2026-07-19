# my-skills

Personal agent skills for the [Skills CLI](https://skills.sh/).

## Layout

```
.claude-plugin/plugin.json
skills/
  <skill-name>/
    SKILL.md
```

## Install (global, symlink)

Install into the **universal** store and **Claude Code** only (symlink; do not use `--copy` or `-a '*'`):

```bash
npx skills add yanggggjie/my-skills -g -y -a universal -a claude-code
```

One skill:

```bash
npx skills add yanggggjie/my-skills -g -y -a universal -a claude-code -s manage-skills
```

From a local clone:

```bash
npx skills add /path/to/my-skills -g -y -a universal -a claude-code
```

## Skills

| Skill | Role |
| --- | --- |
| `manage-skills` | Install / update / create skills via the Skills CLI |
| `repo-cache` | Cache external repos locally for read-only exploration |

## Update

```bash
npx skills update -g
npx skills update manage-skills -g
```

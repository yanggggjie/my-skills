# my-skills

个人 agent skills，由 [Skills CLI](https://skills.sh/) 管理。

## 布局

```
.claude-plugin/plugin.json
skills/
  <skill-name>/
    SKILL.md
```

## 安装（全局、symlink）

只装到 **universal** 与 **Claude Code**（默认 symlink；不要加 `--copy`，不要 `-a '*'`）：

```bash
npx skills add yanggggjie/my-skills -g -y -a universal -a claude-code
```

只装某一个：

```bash
npx skills add yanggggjie/my-skills -g -y -a universal -a claude-code -s manage-skills
```

从本地克隆安装：

```bash
npx skills add /path/to/my-skills -g -y -a universal -a claude-code
```

## Skills

| Skill | 用途 |
| --- | --- |
| `manage-skills` | 用 Skills CLI 安装 / 更新 / 创建 skills |
| `gh-repos` | 用 gh 浅克隆到 `~/.gh-repos`，返回路径供只读探索 |

## 更新

```bash
npx skills update -g
npx skills update manage-skills -g
```

## 工作语言

默认简体中文（含 skill 正文）。见 [`AGENTS.md`](AGENTS.md)。

# my-skills

个人 agent skills，由 [Skills CLI](https://skills.sh/) 管理。

## 布局

```
.claude-plugin/plugin.json
skills/
  <skill-name>/
    SKILL.md
```

## 新机器一键安装（全局 skills）

只装到 **universal** 与 **Claude Code**（默认 symlink；不要加 `--copy`，不要 `-a '*'`）。

复制整块执行：

```bash
FLAGS='-g -y -a universal -a claude-code'

# 整仓（plugin）
npx skills add yanggggjie/my-skills $FLAGS
npx skills add vinvcn/mattpocock-skills-zh-CN $FLAGS

# 单 skill（仓库含多余 skill 时用 -s）
npx skills add Leonxlnx/taste-skill $FLAGS -s design-taste-frontend
npx skills add upstash/context7 $FLAGS -s find-docs
npx skills add vercel-labs/skills $FLAGS -s find-skills
npx skills add steipete/clawdis $FLAGS -s mcporter
npx skills add yanggggjie/terminal-tool-for-agents $FLAGS -s tta
npx skills add yanggggjie/yodo-browser-skill $FLAGS -s yodo-browser-skill

# 之后日常同步
npx skills update -g
```

若 `Leonxlnx/taste-skill` 的 `-s design-taste-frontend` 报找不到，改成 `-s taste-skill`。

只装本仓某一个：

```bash
npx skills add yanggggjie/my-skills -g -y -a universal -a claude-code -s manage-skills
```

从本地克隆安装：

```bash
npx skills add /path/to/my-skills -g -y -a universal -a claude-code
```

## Cursor rules（坚果云）

全局 rules 真源在坚果云，不进本仓：

`Nutstore Files/我的坚果云/sync-config/cursor/rules/`

本机把 `~/.cursor/rules` 链过去（两台都做一次；路径按本机坚果云根目录调整）：

```bash
NUT="$HOME/Nutstore Files/我的坚果云/sync-config/cursor/rules"
# 若 ~/.cursor/rules 已是目录且非空，先迁走或确认可覆盖
rm -rf ~/.cursor/rules
ln -s "$NUT" ~/.cursor/rules
```

不要同步整个 `~/.cursor` 或 `~/.agents`。

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

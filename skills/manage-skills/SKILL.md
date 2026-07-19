---
name: manage-skills
description: 用 Skills CLI 管理 agent skills。在安装、更新、创建、列出或删除 skill 时使用；用户提到 npx skills、skills add/update、全局安装、plugin.json，或 skills/ 仓库布局时使用。
---

# 管理 Skills

**唯一工具：** Skills CLI（`npx skills` / `skills`）。不要另搞平行安装路径。

**正文语言：** 新写或改写的 skill（含 `description`）默认用**简体中文**；`name` 保持英文 kebab-case。仅当用户明确要求其它语言时改用该语言。写结构时加载并遵循 `writing-great-skills`。

**标准布局**（每个 skill 都落在某个 skills 仓库里）：

```
<repo>/
  .claude-plugin/plugin.json
  skills/
    <skill-name>/
      SKILL.md
      …可选附属文件（脚本、commands.md 等）
```

个人仓库：`yanggggjie/my-skills`（本地为其克隆路径）。

## 安装（全局、symlink）

始终全局。始终 symlink（CLI 默认——**不要**传 `--copy`）。
**Agents：** 只要 `universal` 与 `claude-code`——禁止 `-a '*'` / 全量 agents。

```bash
npx skills add <owner/repo> -g -y -a universal -a claude-code
npx skills add <owner/repo> -g -y -a universal -a claude-code -s <skill-name>
npx skills add <skills仓库本地路径> -g -y -a universal -a claude-code
```

完成标准：`npx skills ls -g` 能看到该 skill；内容在 `~/.agents/skills/<name>`（Cursor 读 universal）；Claude Code 为指向该目录的 symlink。

## 更新

```bash
npx skills update -g              # 全部全局
npx skills update <skill-name> -g # 单个
```

完成标准：命令退出码 0；内容已与上游一致（或显示已是最新）。

## 创建

1. **加载** `writing-great-skills`，按其原则写 frontmatter、description、步骤/参考、修剪；**文案用简体中文**。
2. **选定 skills 仓库**（默认 `yanggggjie/my-skills`）。路径必须是 `skills/<skill-name>/SKILL.md`——不要放仓库根、不要顶层单文件 `SKILL.md`。
3. **写出** skill 目录与 `SKILL.md`（及需要披露的附属文件）。
4. **登记** `.claude-plugin/plugin.json`：设置 `name`（插件 id，kebab-case），并在 `skills` 中追加 `"./skills/<skill-name>"`。没有则新建：

```json
{
  "name": "my-skills",
  "version": "1.0.0",
  "description": "个人 agent skills。",
  "skills": [
    "./skills/repo-cache",
    "./skills/manage-skills"
  ]
}
```

5. **全局安装**（symlink，仅 universal + claude-code）：`npx skills add <仓库或路径> -g -y -a universal -a claude-code -s <skill-name>`（省略 `-s` 则刷新整个插件）。
6. 用户需要 GitHub 源带上变更时再 **commit/push**（本地 `skills add` 对 GitHub 源的 `pluginName` 写入不可靠）。

完成标准：存在 `skills/<skill-name>/SKILL.md`，已写入 `plugin.json`，且 `npx skills ls -g` 在对应插件分组下可见（`name` 为 `my-skills` 时即 **My Skills**）。

## 列出 / 删除

```bash
npx skills ls -g
npx skills remove <skill-name> -g -y -a universal -a claude-code
```

## 发现（可选）

```bash
npx skills find <query>
```

找到后仍按上方安装规则安装。需要更完整的发现流程可用 `find-skills`，安装命令不变：`npx skills add … -g -y -a universal -a claude-code`。

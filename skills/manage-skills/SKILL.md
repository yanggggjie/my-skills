---
name: manage-skills
description: 用 Skills CLI 安装、更新、创建、改写、列出或删除 agent skills。用户提到 npx skills、全局安装、plugin.json、skills/ 布局，或要新建/改写任一 skill 时使用。
---

# 管理 Skills

唯一工具：Skills CLI（`npx skills` / `skills`）。

## 写 / 改 skill

新建或改写**任一** skill（含本 skill）时，按序执行：

1. **加载** `writing-great-skills`：Read 其 `SKILL.md`；术语按需查同目录 `GLOSSARY.md`。  
   完成标准：本轮已打开该 skill，且后续正文按其中原则写（信息层级、步骤完成标准、修剪、leading words）——禁止凭记忆硬写。
2. **起草 / 改写** `SKILL.md`（及需披露的附属文件）。文案默认**简体中文**（含 `description`）；`name` 英文 kebab-case。仅用户明确要求其它语言时切换。  
   完成标准：正文通过 `writing-great-skills` 的修剪检查（单一事实源、无 no-op、无重复）。
3. **落盘**到 skills 仓库（默认 `yanggggjie/my-skills`）：路径必须是 `skills/<skill-name>/SKILL.md`。  
   完成标准：文件在该路径，不在仓库根或其它位置。
4. **登记**（仅新建）：在 `.claude-plugin/plugin.json` 的 `skills` 中追加 `"./skills/<skill-name>"`；没有该文件则按下方参考新建。  
   完成标准：`plugin.json` 含该路径。
5. **立刻重装**（见「安装」；通常本地路径 + `-s <skill-name>`）。  
   完成标准：`npx skills ls -g` 可见；`~/.agents/skills/<name>` 已是本次内容。
6. **commit / push** 仅在用户明确要求时做。  
   完成标准：未要求则停在「已落盘 + 已重装」。

## 安装

始终：`-g`、symlink（勿传 `--copy`）、仅 `-a universal -a claude-code`。

```bash
npx skills add <owner/repo> -g -y -a universal -a claude-code
npx skills add <owner/repo> -g -y -a universal -a claude-code -s <skill-name>
npx skills add <skills仓库本地路径> -g -y -a universal -a claude-code
npx skills add <skills仓库本地路径> -g -y -a universal -a claude-code -s <skill-name>
```

完成标准：`npx skills ls -g` 可见；内容在 `~/.agents/skills/<name>`（Cursor 读 universal）；Claude Code 为指向该目录的 symlink。

## 更新

```bash
npx skills update -g              # 全部全局
npx skills update <skill-name> -g # 单个
```

完成标准：退出码 0；内容与上游一致（或已是最新）。

## 列出 / 删除

```bash
npx skills ls -g
npx skills remove <skill-name> -g -y -a universal -a claude-code
```

## 发现

```bash
npx skills find <query>
```

找到后按「安装」安装。更完整的发现流程可用 `find-skills`；安装命令不变。

## 参考

### 布局

```
<repo>/
  .claude-plugin/plugin.json
  skills/
    <skill-name>/
      SKILL.md
      …可选附属文件
```

### plugin.json 示例

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

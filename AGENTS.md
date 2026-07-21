# my-skills

个人 agent skills 仓库。用 [Skills CLI](https://skills.sh/) 管理。

## 工作语言

默认**简体中文**：对用户可见的说明、提交信息、文档与 **新写/改写的 skill 正文**均用中文。

仅当用户明确要求其它语言时切换。代码、命令、路径、skill 的 `name`（kebab-case）可保持英文。

写或改任一 skill 时：**先加载** `writing-great-skills`，按其原则写；**文案用中文**（含 `description` 触发语）。落盘归属与重装规则见 `manage-skills`：

- **个人 skill**（本仓）→ 写完立刻重装
- **项目 skill**（跟产品仓库走）→ 只落在该仓库 `skills/`，不进本仓、默认不全局安装

是否 commit / push 听用户。

## 布局

```
.claude-plugin/plugin.json
skills/
  <skill-name>/
    SKILL.md
```

## 安装约定

全局、symlink，且只装到 `universal` 与 `claude-code`：

```bash
npx skills add yanggggjie/my-skills -g -y -a universal -a claude-code
```

细节见 `skills/manage-skills/SKILL.md`。

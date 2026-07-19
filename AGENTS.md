# my-skills

个人 agent skills 仓库。用 [Skills CLI](https://skills.sh/) 管理。

## 工作语言

默认**简体中文**：对用户可见的说明、提交信息、文档与 **新写/改写的 skill 正文**均用中文。

仅当用户明确要求其它语言时切换。代码、命令、路径、skill 的 `name`（kebab-case）可保持英文。

写 skill 时遵循 `writing-great-skills` 的结构原则，但**文案用中文**（含 `description` 触发语）。

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

细节见 `skills/manage-skills/SKILL.md` 与 `README.md`。

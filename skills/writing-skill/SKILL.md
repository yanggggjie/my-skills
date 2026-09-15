---
name: writing-skill
description: >-
  触发词 ws、writing-skill、写 skill、重写 skill、SKILL.md、梳理 skill。
  用于梳理并撰写 agent skill：小改只处理点名范围，大改先产出 use-case、capability、workflow 三份材料，再写成完整 SKILL.md。
  不负责判定落盘归属、登记插件或安装；这些操作交给 manage-skills。
---

# 起点

触发后先完整读取本 skill 同级 `templates/` 中的三个模板，再判断本次是小改还是大改。

模板位于**已安装的 `writing-skill` 目录**，不是目标 skill 的目录。梳理产物写到目标 `SKILL.md` 同级的 `.temp-skill/`：

```text
<target-skill>/
├── SKILL.md
└── .temp-skill/
    ├── use-case.md
    ├── capability.md
    └── workflow.md
```

三份文件只用于梳理。最终使用者应只读 `SKILL.md` 就能执行任务。

# 判断修改规模

| 类型 | 判断标准 | 梳理文件 | 修改范围 |
|---|---|---|---|
| 小改 | 用户点名局部，且 use case、capability 均不增删 | 不生成 | 只改点名小节 |
| 大改 | 用户要求整份重写，或 use case、capability 有增删 | 生成三份 | 重新组织整份正文 |

判断完成后再动目标文件。用户只要求“梳理”时，大改完成三份材料后停止，不写 `SKILL.md`。

# 大改：梳理材料

大改严格按 `use-case.md → capability.md → workflow.md` 的顺序进行。后一步读取前一步的实际产物，不凭记忆跳写。

## 梳理 use case

先打开 `templates/use-case.md`，再读取与目标 skill 直接相关的材料：

- 用户本轮要求；
- 现有 `SKILL.md`；
- README、脚本、参考文件与附录；
- 对话中明确点名的文件。

不要从无关材料中发明用途。

一条 use case 必须描述一个能够独立完成的目标，并包含：

- `目标：`做成什么；
- `操作：`完成目标所需的动作；
- `可观察结果：`如何确认完成。

步骤、注意事项和还没有发生的设计不是独立 use case，除非用户的目标本身就是完成它们。

完成后，`.temp-skill/use-case.md` 中的每条都应能单独执行并验收。

## 聚合 capability

读取刚写好的 `use-case.md` 和 `templates/capability.md`。

按“经常一起做、共享同一组材料”把 use case 收成少数能力组，通常为两到五个。每个 capability 包含：

1. 一个二级标题；
2. 一段只解释“为什么这些 use case 收在一组”的关系说明；
3. 一行 `覆盖：`，列出对应的 use case 标题。

关系说明不写先后顺序。一个 use case 可以被多个 capability 覆盖；不要为了消除重复而破坏真实能力边界。

## 绘制 workflow

读取刚写好的 `capability.md` 和 `templates/workflow.md`。

用 Mermaid flowchart 表达 capability 之间的交接、条件与分支：

- 节点写 capability 名称；
- 连线写交付物、条件或门闩；
- 旁路、失败、等待和不同处理路径用分支表示；
- 若 capability 只有简单单线顺序，也仍按模板要求画出它们的交接关系。

完成后，读图应能说明能力之间谁先谁后、谁向谁交付什么。

# 落笔写成 SKILL.md

小改只读点名范围及必要上下文，不重写其它章节。大改读取三份梳理文件和所有需要保留的附属材料，再重写完整正文。

梳理文件是写作材料，不是最终目录。按内容关系选择合适的 Markdown 结构：层级用标题，并列或顺序用列表，对照用表格，真实分支用 Mermaid，字面内容用代码格式。不要机械展开 use case 或 capability，也不要为了展示语法而堆结构。

正文必须满足：

- 使用简体中文；只有用户明确要求时才切换语言。
- `name` 使用英文 kebab-case。
- `description` 使用简体中文，写明触发词、何时使用和关键边界。
- 命令、路径、字段名和代码保持字面内容不变。
- 同一段必要操作出现在多处时，每处写完整，不写“同上”或“见上文”。
- 保留现有脚本、参考、附录及不属于本次改动的能力，除非用户明确要求删除。
- 读者只看 `SKILL.md` 就能行动，不必打开 `.temp-skill/`。

# 交付边界

`writing-skill` 的交付物是写好的 `SKILL.md`，以及大改时保留在同级 `.temp-skill/` 的三份材料。

落盘归属、个人仓插件登记、本地重装、更新和删除由 `manage-skills` 处理。不要在本 skill 中自行决定目标属于项目还是个人，也不要代替 `manage-skills` 扩大安装范围。

# 完成标准

- [ ] 修改规模已经明确。
- [ ] 小改没有生成三份梳理文件，也没有改动未点名章节。
- [ ] 大改依次生成了 use-case、capability、workflow 三份文件。
- [ ] capability 的关系说明没有混入流程顺序。
- [ ] workflow 能表达能力之间的交接和真实分支。
- [ ] `SKILL.md` 独立、自洽、可执行，并保留所需附属内容。
- [ ] 落盘与装机事项已交给 `manage-skills`。

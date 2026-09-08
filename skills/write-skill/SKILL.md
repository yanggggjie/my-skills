---
name: write-skill
description: >-
  触发词 ws、write-skill；写或改写 agent skill。
  先梳理出 skills/.temp-txt 下的 use-case.txt、capability.txt、workflow.txt，再写成一份 SKILL.md。
  触发：ws、写 skill、重写 skill、SKILL.md。
  落盘、登记、重装走 manage-skills（ms）。
---

先梳理，再书写。梳理按顺序把 use-case.txt、capability.txt、workflow.txt 写到 skill 同级的 `.temp-txt/`；三份都在，才进入书写。书写只产一份 SKILL.md：开头一段是 capability 之间的关系，一级标题是 capability，二级标题是 use case，具体内容写在二级标题下面。落盘、登记、重装走 manage-skills（触发词 `ms`）。

三个 txt 写在目标 skill 同级的 `.temp-txt/`（即 `skills/.temp-txt/`，和 `skills/<skill-name>/` 并列）。它们是梳理产物，不进 skill 目录；别人执行任务时只读 `SKILL.md`。

## 1. 梳理

先列出 use case，再聚成 capability，最后写出 capability 之间的 workflow。每一步落下一个文件，后一步只读前一步的产出。

### 1.1 列出 use case

从材料里明确这份 skill 的全部基本 use case，写入 `skills/.temp-txt/use-case.txt`。

一条 use case 是：完成一个具体目标而进行的一组操作，并得到可观察结果。不是「第几步」，也不是注意事项。

遍历或查找所有材料：用户这句话、现有 `SKILL.md`、README、脚本、对话里点名的文件。每一条写成「目标 / 操作 / 可观察结果」，让人能单独拿出来做完。不要把还没发生的设计、实现细节、或一次安装预备写成 use case，除非用户就是要做那件事。

可观察结果：`skills/.temp-txt/use-case.txt` 在，每条都能单独拿出来做完。没有这个文件，不要进入 1.2。

### 1.2 聚合成 capability

读 `skills/.temp-txt/use-case.txt`，把 use case 收成少数 capability，写入 `skills/.temp-txt/capability.txt`。

按「经常一起做、共享同一组材料」归类。通常两到五个。不要每个 use case 单独升成一个 capability。每个 capability 写清覆盖哪些 use case。

可观察结果：`skills/.temp-txt/capability.txt` 在，每个 capability 都能在 `use-case.txt` 里找到它覆盖的那些条。没有这个文件，不要进入 1.3。

### 1.3 写出 workflow

读 `skills/.temp-txt/capability.txt`，写出 capability 相互之间的流程，写入 `skills/.temp-txt/workflow.txt`。

用一段话写清谁先谁后、谁的产出被谁用。不要再开一套标题，也不要把这段话写成步骤清单去替代 `capability.txt`。

可观察结果：`skills/.temp-txt/workflow.txt` 在，读完能说出 capability 的顺序和交接。三份都在，才进入书写。

## 2. 书写

三份都在，才写那一份 `SKILL.md`。workflow 是一段话，capability 是一级标题，use case 是二级标题，具体内容写在二级标题下面。

### 2.1 写成 SKILL.md

读 `skills/.temp-txt/` 里的 `workflow.txt`、`capability.txt`、`use-case.txt`，写成一份 `SKILL.md`。

正文开头先写一段话，内容来自 `workflow.txt`：这几个 capability 怎么动、谁推谁。不要把这段话做成标题。

每个 capability 做一个一级标题，写成 `1.` `2.` `3.`，标题就是 capability 的名字。

该 capability 覆盖的每个 use case 做一个二级标题，写成 `1.1` `1.2`，标题就是 use case 的名字。二级标题下面写具体内容：做什么、看哪一个字或哪一份文件、完了是什么。写完整句子。命令、路径、这次输出里的字段保持字面量，不改写。

整份正文像树一样展开。同一条 use case 被多个 capability 用到时，每个 capability 下面都写完整的一份，意思对齐。不写「同上」，不写「见上文」。不要把 `1.` `2.` `3.` 互相抄一遍；重复的是 use case 那段动作，不是整章。

frontmatter：`name` 英文 kebab-case；`description` 简体中文，写清触发词。正文默认简体中文；只有用户明确要求其它语言时才切换。

可观察结果：目标 skill 目录里有一份 `SKILL.md`。读完能按 `1.` `1.1` 做下去，不必再翻三个 txt 才能动手。不要再写第四个 txt 来代替这份 skill。

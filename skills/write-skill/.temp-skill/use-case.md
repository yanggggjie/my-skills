# use case

一条 use case：完成一个具体目标而进行的一组操作，并得到可观察结果。

## 判定小改或大改
目标：先定这次是只改点名小节，还是要重梳
操作：
- 小改：用户点名的局部，capability 和 use case 目录都不增删
- 大改：capability 或 use case 要增删，或用户要重写整份
可观察结果：已定小改或大改；小改不进入列出 use case

## 列出 use case
目标：从材料里明确这份 skill 的全部基本 use case
操作：
1. 打开和本 SKILL.md 同级的 `templates/use-case.md`
2. 遍历用户这句话、现有 SKILL.md、README、脚本、对话里点到的文件
3. 按模板写成「目标 / 操作 / 可观察结果」
可观察结果：目标 `SKILL.md` 同级的 `.temp-skill/use-case.md` 在，每条都能单独拿出来做完

## 聚合成 capability
目标：把 use case 收成少数 capability，只写为什么收在一组
操作：
1. 打开 `templates/capability.md`
2. 按「经常一起做、共享同一组材料」归类，通常两到五个
3. 关系说明只写为什么收在一组；谁先谁后留给 workflow
4. 同一条 use case 可以落在多个 capability；书写时每处写全文，不收归
可观察结果：目标 `SKILL.md` 同级的 `.temp-skill/capability.md` 在，每个 capability 能在 use-case.md 里找到覆盖的那些条

## 写出 workflow
目标：用 Mermaid 图写清 capability 谁先谁后、谁的产出给谁
操作：打开 `templates/workflow.md`，按模板把图画进 mermaid 围栏；旁路、失败、等人用分支
可观察结果：目标 `SKILL.md` 同级的 `.temp-skill/workflow.md` 在，读完图能说出顺序和交接

## 写成 SKILL.md
目标：交出一份可执行的 SKILL.md
操作：
- 大改：读三份 md，按表达规定展开树
- 小改：只改点名小节，仍遵守表达规定
- 已有参考、脚本、附录默认保留
- frontmatter 写清触发词、何时用、何时不用
可观察结果：目标 skill 目录有一份 SKILL.md，读完能按 1. / 1.1 做下去

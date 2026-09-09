# workflow

对着这份模板写目标 `SKILL.md` 同级的 `.temp-skill/workflow.md`。不要把模板本身拷进 `.temp-skill/`。先读已经写好的 `capability.md`，再画图。

用 Mermaid flowchart 写 capability 之间谁先谁后、谁的产出给谁（本 skill「表达规定」里的流程图）。不要用一段话代替图。节点写 capability 名字；边上写交出的文件或门闩。旁路、失败、等人，用分支画出来。

图放在下面这个 mermaid 围栏里。书写 `SKILL.md` 时，开头先写一句触发和第一下做什么，再把围栏里的图放上去。

```mermaid
flowchart TD
  A["<capability-A>"] -->|"交出 <文件或状态>"| B["<capability-B>"]
  B -->|<条件>| C["<下一步>"]
  B -->|<条件>| D[停]
```

读完这张图，要能说出 capability 的顺序和交接。

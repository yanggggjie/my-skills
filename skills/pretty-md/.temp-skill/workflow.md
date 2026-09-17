# workflow

```mermaid
flowchart TD
  A[内容整理] -->|交出简化后的三层内容树| B[格式表达]
  B -->|交出整理后的 Markdown| C[内容整理]
  C -->|保真检查通过| D[交付]
  C -->|发现遗漏或改义| A
```

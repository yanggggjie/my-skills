# workflow

```mermaid
flowchart TD
  material[材料] --> pick[选用块]
  pick -->|只问用哪种| stop[交出选定]
  pick -->|要写成篇| write[写出 md]
  write --> out[交出 md]
```

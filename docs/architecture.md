# 架构说明

```text
MySQL 业务库
    │ DataX
    ▼
ODS 原始层（按 dt 分区）
    ├── DIM 维度层（用户/商品 SCD2）
    └── DWD 明细层（清洗、脱敏、统一口径）
            ▼
       DWS 汇总层（用户/商品/日期）
            ▼
       ADS 应用层（业务指标报表）
```

Shell 脚本负责按 T+1 顺序调用 DataX 和 Hive SQL，质量脚本在各阶段检查分区是否存在、关键字段是否为空以及金额是否出现非法值。生产环境可将 Shell 调度替换为 Airflow、Azkaban 或 DolphinScheduler。

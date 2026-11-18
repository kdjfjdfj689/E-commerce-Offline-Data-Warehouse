# 电商离线数仓项目

这是一个面向教学、面试和本地演示的 Hive 离线数仓项目骨架，覆盖 MySQL → DataX → ODS → DIM/DWD → DWS → ADS 的 T+1 数据链路。

## 项目结构

```text
conf/       DataX 与 Hive 环境配置
data/       本地最小样例数据
docs/       数据模型、指标口径和架构说明
shell/      同步、调度和质量检查脚本
sql/        ODS、DIM、DWD、DWS、ADS 分层 SQL
```

## 快速开始

1. 修改 `conf/datax/*.json` 中的 MySQL 连接信息。
2. 修改 `conf/hive_env.conf` 中的 Hive 数据库和仓库路径。
3. 准备 HDFS、Hive、DataX 环境，并确认 `hive`、`hdfs`、`python` 命令可用。
4. 执行 `bash shell/dw_pipeline.sh 2026-01-01` 运行指定业务日期的 T+1 链路。
5. 本地无集群时，可使用 `data/sample/` 校验字段和 SQL 设计。

## 分层说明

- ODS：保存业务库原始数据，尽量少做加工。
- DIM：维护用户、商品等维度，示例包含 SCD2 拉链。
- DWD：清洗订单明细，过滤非法记录并进行手机号脱敏。
- DWS：按日期、用户、商品形成轻度汇总宽表。
- ADS：面向业务报表输出核心指标。

## 简历描述

负责搭建电商离线数仓分层体系，使用 DataX 完成 MySQL 到 Hive ODS 的增量同步，基于 Hive SQL 实现 SCD2 维度拉链、事实明细清洗、用户与商品主题汇总及 ADS 指标报表，并通过 Shell 脚本实现 T+1 链路编排和数据质量校验。

## 面试指引

- 为什么采用 ODS/DIM/DWD/DWS/ADS 分层？
- SCD2 拉链如何处理新增、变更、删除和重复数据？
- 如何保证 DataX 同步幂等？
- 脏数据过滤、脱敏和数据质量规则有哪些？
- 如何优化 Hive 分区、文件数量和小表关联？

## 注意事项

配置中的主机、账号、密码和路径均为占位符。上线前请按实际集群、业务表结构和调度平台调整，严禁把真实密码提交到 Git。

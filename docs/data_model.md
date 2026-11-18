# 数据模型与分层说明

## 业务实体

| 实体 | 粒度 | 关键字段 |
| --- | --- | --- |
| 用户 | 一行一个用户版本 | user_id、phone、status、start_date、end_date |
| 商品 | 一行一个商品版本 | product_id、category_id、price、start_date、end_date |
| 订单明细 | 一行一个订单商品行 | order_id、user_id、product_id、quantity、amount |
| 点击日志 | 一行一次点击事件 | user_id、product_id、page、event_time |

## 分层约定

- ODS 使用外部表，按 `dt` 分区保存原始快照或同步数据。
- DIM 使用拉链表保存维度历史版本，当前版本 `end_date = '9999-12-31'`。
- DWD 统一字段类型、过滤关键字段为空和金额小于零的记录。
- DWS 按业务日期聚合，避免报表层重复扫描明细。
- ADS 只保留面向报表和面试展示的指标结果。

## 主键与分区

- 用户、商品主键分别为 `user_id`、`product_id`。
- 订单明细使用 `order_id + product_id` 作为业务唯一键示例。
- 事实和汇总表按 `dt` 分区；查询必须带业务日期分区条件。

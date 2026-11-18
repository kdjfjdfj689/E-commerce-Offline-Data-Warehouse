USE ecommerce_dw;

CREATE TABLE IF NOT EXISTS dws_user_day (
  user_id STRING, pay_order_cnt BIGINT, pay_amount DECIMAL(18,2), click_cnt BIGINT
) PARTITIONED BY (dt STRING) STORED AS ORC;

CREATE TABLE IF NOT EXISTS dws_product_day (
  product_id STRING, pay_order_cnt BIGINT, pay_user_cnt BIGINT, pay_amount DECIMAL(18,2), click_cnt BIGINT, click_user_cnt BIGINT
) PARTITIONED BY (dt STRING) STORED AS ORC;

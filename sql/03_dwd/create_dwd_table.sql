USE ecommerce_dw;

CREATE TABLE IF NOT EXISTS dwd_order_detail (
  order_id STRING, user_id STRING, product_id STRING, quantity BIGINT,
  pay_amount DECIMAL(16,2), order_status STRING, masked_phone STRING
) PARTITIONED BY (dt STRING) STORED AS ORC;

CREATE TABLE IF NOT EXISTS dwd_click_log (
  user_id STRING, product_id STRING, page STRING, event_time TIMESTAMP
) PARTITIONED BY (dt STRING) STORED AS ORC;

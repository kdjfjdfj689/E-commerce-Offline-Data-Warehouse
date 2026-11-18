USE ecommerce_dw;

CREATE EXTERNAL TABLE IF NOT EXISTS ods_user (
  user_id STRING, phone STRING, status STRING, updated_at STRING
) PARTITIONED BY (dt STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE LOCATION '/warehouse/ecommerce_dw/ods/ods_user';

CREATE EXTERNAL TABLE IF NOT EXISTS ods_order (
  order_id STRING, user_id STRING, product_id STRING, quantity BIGINT,
  pay_amount DECIMAL(16,2), order_status STRING, updated_at STRING
) PARTITIONED BY (dt STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE LOCATION '/warehouse/ecommerce_dw/ods/ods_order';

CREATE EXTERNAL TABLE IF NOT EXISTS ods_click_log (
  user_id STRING, product_id STRING, page STRING, event_time STRING
) PARTITIONED BY (dt STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE LOCATION '/warehouse/ecommerce_dw/ods/ods_click_log';

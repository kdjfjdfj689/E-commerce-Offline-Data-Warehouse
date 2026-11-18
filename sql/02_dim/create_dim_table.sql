USE ecommerce_dw;

CREATE TABLE IF NOT EXISTS dim_user_zip (
  user_id STRING, phone STRING, status STRING, start_date STRING, end_date STRING, is_current TINYINT
) STORED AS ORC;

CREATE TABLE IF NOT EXISTS dim_product_zip (
  product_id STRING, category_id STRING, product_name STRING, price DECIMAL(16,2), start_date STRING, end_date STRING, is_current TINYINT
) STORED AS ORC;

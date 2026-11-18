USE ecommerce_dw;

CREATE TABLE IF NOT EXISTS ads_business_day (
  pay_order_cnt BIGINT, pay_user_cnt BIGINT, pay_amount DECIMAL(18,2),
  avg_order_amount DECIMAL(18,2), click_cnt BIGINT, click_user_cnt BIGINT
) PARTITIONED BY (dt STRING) STORED AS ORC;

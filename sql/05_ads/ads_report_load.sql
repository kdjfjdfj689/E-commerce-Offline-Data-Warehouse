USE ecommerce_dw;

INSERT OVERWRITE TABLE ads_business_day PARTITION (dt='${bizdate}')
SELECT SUM(pay_order_cnt), SUM(pay_user_cnt), SUM(pay_amount),
       CASE WHEN SUM(pay_order_cnt)=0 THEN 0 ELSE SUM(pay_amount)/SUM(pay_order_cnt) END,
       SUM(click_cnt), SUM(click_user_cnt)
FROM dws_product_day WHERE dt='${bizdate}';

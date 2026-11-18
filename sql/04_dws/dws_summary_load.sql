USE ecommerce_dw;

INSERT OVERWRITE TABLE dws_user_day PARTITION (dt='${bizdate}')
SELECT COALESCE(o.user_id, c.user_id),
       COALESCE(o.pay_order_cnt, 0), COALESCE(o.pay_amount, 0), COALESCE(c.click_cnt, 0)
FROM (SELECT user_id, COUNT(DISTINCT order_id) pay_order_cnt, SUM(pay_amount) pay_amount
      FROM dwd_order_detail WHERE dt='${bizdate}' AND order_status='PAID' GROUP BY user_id) o
FULL OUTER JOIN (SELECT user_id, COUNT(*) click_cnt FROM dwd_click_log WHERE dt='${bizdate}' GROUP BY user_id) c
ON o.user_id = c.user_id;

INSERT OVERWRITE TABLE dws_product_day PARTITION (dt='${bizdate}')
SELECT COALESCE(o.product_id, c.product_id), COALESCE(o.pay_order_cnt, 0), COALESCE(o.pay_user_cnt, 0),
       COALESCE(o.pay_amount, 0), COALESCE(c.click_cnt, 0), COALESCE(c.click_user_cnt, 0)
FROM (SELECT product_id, COUNT(DISTINCT order_id) pay_order_cnt, COUNT(DISTINCT user_id) pay_user_cnt, SUM(pay_amount) pay_amount
      FROM dwd_order_detail WHERE dt='${bizdate}' AND order_status='PAID' GROUP BY product_id) o
FULL OUTER JOIN (SELECT product_id, COUNT(*) click_cnt, COUNT(DISTINCT user_id) click_user_cnt
                 FROM dwd_click_log WHERE dt='${bizdate}' GROUP BY product_id) c
ON o.product_id = c.product_id;

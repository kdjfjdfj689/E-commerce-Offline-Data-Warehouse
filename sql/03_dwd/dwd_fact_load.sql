USE ecommerce_dw;

INSERT OVERWRITE TABLE dwd_order_detail PARTITION (dt='${bizdate}')
SELECT o.order_id, o.user_id, o.product_id, o.quantity, o.pay_amount, o.order_status,
       CASE WHEN u.phone IS NULL OR LENGTH(u.phone) < 7 THEN NULL
            ELSE CONCAT(SUBSTR(u.phone, 1, 3), '****', SUBSTR(u.phone, -4)) END AS masked_phone
FROM ods_order o LEFT JOIN dim_user_zip u
  ON o.user_id = u.user_id AND u.is_current = 1
WHERE o.dt = '${bizdate}' AND o.order_id IS NOT NULL AND o.user_id IS NOT NULL
  AND o.quantity > 0 AND o.pay_amount >= 0;

INSERT OVERWRITE TABLE dwd_click_log PARTITION (dt='${bizdate}')
SELECT user_id, product_id, page, CAST(event_time AS TIMESTAMP)
FROM ods_click_log
WHERE dt = '${bizdate}' AND user_id IS NOT NULL AND product_id IS NOT NULL;

USE ecommerce_dw;

-- 示例：用户维度 SCD2。实际生产中应先识别变更，再关闭旧版本并插入新版本。
WITH src AS (
  SELECT user_id, phone, status, '${bizdate}' AS start_date
  FROM ods_user WHERE dt = '${bizdate}'
), changed AS (
  SELECT s.* FROM src s LEFT JOIN dim_user_zip d
    ON s.user_id = d.user_id AND d.is_current = 1
  WHERE d.user_id IS NULL OR COALESCE(s.phone, '') <> COALESCE(d.phone, '')
     OR COALESCE(s.status, '') <> COALESCE(d.status, '')
)
INSERT OVERWRITE TABLE dim_user_zip
SELECT user_id, phone, status, start_date, end_date, is_current FROM dim_user_zip
WHERE is_current = 0 OR user_id NOT IN (SELECT user_id FROM changed)
UNION ALL
SELECT d.user_id, d.phone, d.status, d.start_date, '${bizdate}', 0
FROM dim_user_zip d JOIN changed c ON d.user_id = c.user_id AND d.is_current = 1
UNION ALL
SELECT user_id, phone, status, start_date, '9999-12-31', 1 FROM changed;

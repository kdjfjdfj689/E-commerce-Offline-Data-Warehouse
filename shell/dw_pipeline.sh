#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BIZDATE="${1:-$(date -d '1 day ago' +%F)}"
HIVE_BIN="${HIVE_BIN:-hive}"
DB="${DW_DB:-ecommerce_dw}"

run_sql() { echo "[INFO] $1"; "${HIVE_BIN}" --hiveconf bizdate="${BIZDATE}" -f "${BASE_DIR}/$1"; }
"${BASE_DIR}/shell/sync_ods.sh" "${BIZDATE}"
run_sql sql/01_ods/create_ods_table.sql
run_sql sql/02_dim/create_dim_table.sql
run_sql sql/02_dim/dim_zip_load.sql
run_sql sql/03_dwd/create_dwd_table.sql
run_sql sql/03_dwd/dwd_fact_load.sql
run_sql sql/04_dws/create_dws_table.sql
run_sql sql/04_dws/dws_summary_load.sql
run_sql sql/05_ads/create_ads_table.sql
run_sql sql/05_ads/ads_report_load.sql
"${BASE_DIR}/shell/data_quality_check.sh" "${BIZDATE}"

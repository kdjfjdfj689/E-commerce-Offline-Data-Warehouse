#!/usr/bin/env bash
set -euo pipefail

BIZDATE="${1:-$(date -d '1 day ago' +%F)}"
HIVE_BIN="${HIVE_BIN:-hive}"
DB="${DW_DB:-ecommerce_dw}"

check_count() {
  local table="$1"
  local count
  count=$("${HIVE_BIN}" --database "${DB}" --hiveconf bizdate="${BIZDATE}" -S -e "SELECT COUNT(*) FROM ${table} WHERE dt='${BIZDATE}';" | tail -n 1)
  [[ "${count}" =~ ^[0-9]+$ ]] && [[ "${count}" -ge 0 ]] || { echo "[ERROR] invalid count for ${table}: ${count}"; exit 1; }
  echo "[PASS] ${table}: ${count} rows"
}

for table in ods_order dwd_order_detail dws_product_day ads_business_day; do check_count "${table}"; done

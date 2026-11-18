#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BIZDATE="${1:-$(date -d '1 day ago' +%F)}"
DATAX_HOME="${DATAX_HOME:-/opt/datax}"

for config in ods_user ods_order ods_click_log; do
  echo "[INFO] syncing ${config}, bizdate=${BIZDATE}"
  python "${DATAX_HOME}/bin/datax.py" "${BASE_DIR}/conf/datax/${config}.json" -p "-Dbizdate=${BIZDATE}"
done

SYSTEM_DIR="/data/system/taichi"
WATCH_FILE="/data/misc/taichi"
ENFORCE_FILE="/data/misc/taichi_enforce"
LOG_FILE="/data/local/tmp/taichi.log"

rm -rf "${SYSTEM_DIR}" 2>/dev/null
rm -f "${WATCH_FILE}" 2>/dev/null
rm -f "${ENFORCE_FILE}" 2>/dev/null
rm -f "${LOG_FILE}" 2>/dev/null
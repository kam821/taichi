# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed.
# This will make sure your module will still work
# if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in post-fs-data mode

WATCH_FILE="/data/misc/taichi"
ENFORCE_FILE="/data/misc/taichi_enforce"
LOG_FILE="/data/local/tmp/taichi.log"
SEPOLICY_FILE="${MODDIR}/sepolicy.rule"

rm -f "{WATCH_FILE}" 2>/dev/null
rm -f "{ENFORCE_FILE}" 2>/dev/null
rm -f "{LOG_FILE}" 2>/dev/null

# Load utility functions
[ -f "/data/adb/magisk/util_functions.sh" ] && . /data/adb/magisk/util_functions.sh
[ "${MAGISK_VER_CODE}" -ge 20110 ] && exit 0

AB_UPDATE=$(getprop ro.build.ab_update)
grep ' / ' /proc/mounts | grep -qv 'rootfs' && SAR="true" || SAR="false"
[ "${AB_UPDATE}" != "true" ] || ([ "${AB_UPDATE}" == "true" ] && [ "${SAR}" == "false" ]) && SETENFORCE="true" || SETENFORCE="false"

if ([ $(getprop ro.build.version.sdk) -ge 29 ] && [ "${SETENFORCE}" == "true" ]) || [ ! -f "${SEPOLICY_FILE}" ]; then
  touch "${ENFORCE_FILE}" 2>/dev/null
  setenforce 0
else
  grep -v '^#' < "${SEPOLICY_FILE}" | while read RULE; do
    magiskpolicy --live "${RULE}" 2>/dev/null
  done
fi
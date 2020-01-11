#!/system/bin/sh
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed.
# This will make sure your module will still work
# if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in late_start service mode
# More info in the main Magisk thread

WATCH_FILE="/data/misc/taichi"
ENFORCE_FILE="/data/misc/taichi_enforce"

timeout=10
while [ ! -f "${WATCH_FILE}" ] && [ "$timeout" -gt 0 ]; do
   timeout=$((timeout-1))
   sleep 1
done

if [ ! -f "${WATCH_FILE}" ]; then
  setprop ctl.restart zygote_secondary >&2
else
  rm -f "${WATCH_FILE}"
fi

until [ $(getprop sys.boot_completed) -eq 1 ]; do
  sleep 1
done

if [ -f "${ENFORCE_FILE}" ]; then
  rm -f "${ENFORCE_FILE}"
  setenforce 1
fi
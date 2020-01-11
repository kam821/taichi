# Set what you want to display when installing your module
print_modname() {
  ui_print "*******************************"
  ui_print "        TaiChi - Magisk        "
  ui_print "                               "
  ui_print "          by @weishu           "
  ui_print "                               "
  ui_print "      https://taichi.cool      "
  ui_print "*******************************"
}

on_install() {
  ui_print "- Extracting module files"
  unzip -oj "$ZIPFILE" taichi module.prop uninstall.sh 'common/*' -d $MODPATH >&2
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
  
  chmod 0100 $MODPATH/taichi
  $MODPATH/taichi $MODPATH $MODPATH
  rm -f $MODPATH/taichi 2>&1 >/dev/null

  [ $? -eq 0 ] && ui_print "Installed." || abort "Install error: $?"
}

set_permissions() {
  ui_print "- Setting permissions"
  # The following is the default rule, DO NOT remove
  set_perm_recursive $MODPATH  0  0  0755  0644
  # set_perm  $MODPATH/system/lib/libmedia_legacy.so    0    0    0644    u:object_r:system_lib_file:s0
}

SKIPUNZIP=1
print_modname
on_install
set_permissions
#!/system/bin/sh
# Magisk module installer script

# Set permissions for scripts
set_perm_recursive $MODPATH/webroot/cgi-bin 0 0 0755 0755
set_perm $MODPATH/action.sh 0 0 0755

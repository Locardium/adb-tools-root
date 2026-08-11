#!/system/bin/sh
# Magisk module installer script

ui_print "- Extracting WebUI files..."
unzip -o "$ZIPFILE" 'webroot/*' -d $MODPATH >&2
unzip -o "$ZIPFILE" 'action.sh' -d $MODPATH >&2

# Set permissions for scripts
set_perm_recursive $MODPATH/webroot/cgi-bin 0 0 0755 0755
set_perm $MODPATH/action.sh 0 0 0755

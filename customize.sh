#!/system/bin/sh
# Magisk module installer script

# Set permissions for CGI scripts to allow execution
set_perm_recursive $MODPATH/webroot/cgi-bin 0 0 0755 0755

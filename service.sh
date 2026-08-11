#!/system/bin/sh
MODDIR=${0%/*}

# Wait for boot to finish
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done

CONFIG_FILE="$MODDIR/system/etc/adb_webui/config.prop"

# Source the config file if it exists, otherwise use defaults
if [ -f "$CONFIG_FILE" ]; then
    . "$CONFIG_FILE"
else
    ENABLE_WIRELESS_ON_BOOT=true
    ENABLE_USB_ON_BOOT=true
    ADB_PORT=5555
    WEBUI_PORT=8080
fi

# Apply USB ADB setting
if [ "$ENABLE_USB_ON_BOOT" = "true" ]; then
    resetprop persist.sys.usb.config adb
fi

# Apply Wireless ADB setting
if [ "$ENABLE_WIRELESS_ON_BOOT" = "true" ]; then
    resetprop service.adb.tcp.port "$ADB_PORT"
else
    resetprop service.adb.tcp.port -1
fi

# Restart adbd to apply changes reliably
resetprop ctl.restart adbd
stop adbd
start adbd

# Start the WebUI using busybox httpd
# Webroot is $MODDIR/webroot
killall httpd
busybox httpd -p "$WEBUI_PORT" -h "$MODDIR/webroot"

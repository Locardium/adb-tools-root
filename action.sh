#!/system/bin/sh

MODDIR=${0%/*}
CONFIG_FILE="$MODDIR/system/etc/adb_webui/config.prop"

if [ "$1" = "save" ]; then
    ENABLE_WIRELESS="$2"
    ENABLE_USB="$3"
    ADB_PORT="$4"
    LOOP_INTERVAL="$5"
    
    [ -z "$LOOP_INTERVAL" ] && LOOP_INTERVAL="5"

    mkdir -p $(dirname "$CONFIG_FILE")
    echo "ENABLE_WIRELESS_ON_BOOT=$ENABLE_WIRELESS" > "$CONFIG_FILE"
    echo "ENABLE_USB_ON_BOOT=$ENABLE_USB" >> "$CONFIG_FILE"
    echo "ADB_PORT=$ADB_PORT" >> "$CONFIG_FILE"
    echo "WEBUI_PORT=8080" >> "$CONFIG_FILE"
    echo "LOOP_INTERVAL=$LOOP_INTERVAL" >> "$CONFIG_FILE"

    if [ "$ENABLE_USB" = "true" ]; then
        resetprop persist.sys.usb.config adb
    fi

    if [ "$ENABLE_WIRELESS" = "true" ]; then
        resetprop service.adb.tcp.port "$ADB_PORT"
    else
        resetprop service.adb.tcp.port -1
    fi

    resetprop ctl.restart adbd
    stop adbd
    start adbd
    echo "Success"
fi

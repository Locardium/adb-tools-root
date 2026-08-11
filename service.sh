#!/system/bin/sh
MODDIR=${0%/*}

# Wait for boot to finish
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done

CONFIG_FILE="$MODDIR/system/etc/adb_webui/config.prop"

# Function to load config
load_config() {
    if [ -f "$CONFIG_FILE" ]; then
        . "$CONFIG_FILE"
    else
        ENABLE_WIRELESS_ON_BOOT=true
        ENABLE_USB_ON_BOOT=true
        ADB_PORT=5555
        WEBUI_PORT=8080
        LOOP_INTERVAL=5
    fi
}

load_config

# Start the WebUI using busybox httpd
killall httpd
busybox httpd -p "$WEBUI_PORT" -h "$MODDIR/webroot"

# Keep-Alive Loop in background
(
    while true; do
        # Reload config in case it was changed via WebUI
        load_config
        
        needs_restart=false

        if [ "$ENABLE_USB_ON_BOOT" = "true" ]; then
            current_usb=$(getprop persist.sys.usb.config)
            case "$current_usb" in
                *adb*) ;; # already has adb
                *) resetprop persist.sys.usb.config adb; needs_restart=true ;;
            esac
        fi

        if [ "$ENABLE_WIRELESS_ON_BOOT" = "true" ]; then
            if [ "$(getprop service.adb.tcp.port)" != "$ADB_PORT" ]; then
                resetprop service.adb.tcp.port "$ADB_PORT"
                needs_restart=true
            fi
        else
            if [ "$(getprop service.adb.tcp.port)" != "-1" ]; then
                resetprop service.adb.tcp.port -1
                needs_restart=true
            fi
        fi

        if [ "$needs_restart" = "true" ] || [ "$(getprop init.svc.adbd)" != "running" ]; then
            resetprop ctl.restart adbd
            stop adbd
            start adbd
        fi

        # Sleep for the configured interval
        sleep "$LOOP_INTERVAL"
    done
) &

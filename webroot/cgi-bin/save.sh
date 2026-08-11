#!/system/bin/sh

# Send HTTP response headers
echo "Content-type: text/html"
echo ""

# Parse QUERY_STRING (e.g., wireless=on&adb_port=5555&usb=on)
ENABLE_WIRELESS="false"
ENABLE_USB="false"
ADB_PORT="5555"

case "$QUERY_STRING" in
    *wireless=on*) ENABLE_WIRELESS="true" ;;
esac

case "$QUERY_STRING" in
    *usb=on*) ENABLE_USB="true" ;;
esac

# Extract adb_port securely using sed or grep
port=$(echo "$QUERY_STRING" | grep -o 'adb_port=[0-9]*' | cut -d'=' -f2)
if [ ! -z "$port" ]; then
    ADB_PORT="$port"
fi

MODDIR="/data/adb/modules/wireless-adb-webui"
CONFIG_FILE="$MODDIR/system/etc/adb_webui/config.prop"

# Save configuration to file
mkdir -p $(dirname "$CONFIG_FILE")
echo "ENABLE_WIRELESS_ON_BOOT=$ENABLE_WIRELESS" > "$CONFIG_FILE"
echo "ENABLE_USB_ON_BOOT=$ENABLE_USB" >> "$CONFIG_FILE"
echo "ADB_PORT=$ADB_PORT" >> "$CONFIG_FILE"
echo "WEBUI_PORT=8080" >> "$CONFIG_FILE"

# Apply settings immediately
if [ "$ENABLE_USB" = "true" ]; then
    resetprop persist.sys.usb.config adb
fi

if [ "$ENABLE_WIRELESS" = "true" ]; then
    resetprop service.adb.tcp.port "$ADB_PORT"
else
    resetprop service.adb.tcp.port -1
fi

# Restart ADB Daemon
resetprop ctl.restart adbd
stop adbd
start adbd

# Output success page
cat <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Saved!</title>
    <meta http-equiv="refresh" content="3;url=/">
    <style>
        body { background: #0f172a; color: #f8fafc; font-family: sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .box { background: rgba(30,41,59,0.7); padding: 2rem; border-radius: 12px; text-align: center; border: 1px solid rgba(255,255,255,0.1); }
    </style>
</head>
<body>
    <div class="box">
        <h2>Settings Applied Successfully!</h2>
        <p>ADB has been restarted with your new settings.</p>
        <p>Redirecting back in 3 seconds...</p>
    </div>
</body>
</html>
EOF

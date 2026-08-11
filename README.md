# ADB Tools Root (Magisk/KernelSU Module)

This module automatically enables ADB over Wi-Fi and USB on boot, and provides a lightweight Web UI to manage these settings dynamically.

## Features

- Always enable ADB Wireless on boot.
- Always enable ADB via USB on boot.
- Custom ADB port (default `5555`).
- Built-in Web UI accessible on port `8080`.

## Installation

1. Clone or download this repository.
2. Zip all the files inside the folder (do not zip the folder itself, just its contents).
3. Open Magisk or KernelSU Manager and install the zip from storage.
4. Reboot your device.

## Usage

After rebooting, make sure you are on the same Wi-Fi network as your Android device.

Open a web browser and go to:
`http://<YOUR_DEVICE_IP>:8080`

From there, you can toggle ADB over Wi-Fi/USB and change the port on the fly.

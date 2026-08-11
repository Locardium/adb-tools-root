# ADB Tools Root (Magisk/KernelSU Module)

This module automatically enables ADB over Wi-Fi and USB on boot, and provides a lightweight Web UI to manage these settings dynamically.

## Features

- Always enable ADB Wireless on boot.
- Always enable ADB via USB on boot.
- Custom ADB port (default `5555`).
- Built-in Web UI.

## Installation

1. Clone or download this repository.
2. Zip all the files inside the folder (do not zip the folder itself, just its contents).
3. Open Magisk or KernelSU Manager and install the zip from storage.
4. Reboot your device.

## Usage

This module is designed to be managed using the **KsuWebUI** app.

1. Download and install a KsuWebUI compatible app (e.g. [KsuWebUI](https://github.com/adivenxnataly/KsuWebUI)).
2. Open the app, and you will see "ADB Tools Root" in the module list.
3. Tap on it to open the built-in configuration dashboard.

From there, you can toggle ADB over Wi-Fi/USB, change the port on the fly, and adjust the Keep-Alive loop interval.

*(Fallback)*: If you are not using KsuWebUI, you can still access the dashboard by opening a web browser and navigating to `http://<YOUR_DEVICE_IP>:8080`.

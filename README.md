# Wireless ADB WebUI (Magisk Module)

Este módulo de Magisk habilita automáticamente ADB a través de Wi-Fi y USB en el arranque, y proporciona una interfaz web ligera para administrar estas configuraciones.

## Características

- Habilita automáticamente ADB Inalámbrico al encender el dispositivo.
- Habilita automáticamente ADB vía USB al encender el dispositivo.
- Puerto ADB personalizable (por defecto `5555`).
- Interfaz web incorporada accesible en el puerto `8080`.

## Instalación

1. Clona o descarga este repositorio.
2. Comprime todos los archivos dentro de la carpeta en un archivo `.zip` (asegúrate de seleccionar los archivos, no la carpeta en sí).
3. Abre Magisk Manager e instala el zip desde el almacenamiento.
4. Reinicia tu dispositivo.

## Uso

Después de reiniciar, asegúrate de estar en la misma red Wi-Fi que tu dispositivo Android.

Abre un navegador web y ve a:
`http://<IP_DE_TU_DISPOSITIVO>:8080`

Desde allí, puedes encender o apagar ADB sobre Wi-Fi/USB y cambiar el puerto en tiempo real.

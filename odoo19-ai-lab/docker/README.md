# Docker

El Compose es una base de ejemplo, no una sustitución automática del Compose del centro.

Completar/verificar:
- Imagen Odoo 19 utilizada por el centro.
- Imagen y versión PostgreSQL.
- Nombre del servicio Odoo y base de datos.
- Contraseña maestra y credenciales.
- Puertos y volúmenes.
- `addons_path` real de la imagen.
- Ruta de `~/odoo/src` en `.env`.

El montaje `/mnt/odoo-src:ro` permite que las herramientas dentro del contenedor lean los fuentes. Para que el agente del IDE acceda a `~/odoo/src`, puede abrirse también esa carpeta en el workspace multi-root de VS Code o configurarse el acceso de archivos del agente. El montaje Docker, por sí solo, no concede acceso al agente que se ejecuta en el host.

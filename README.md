# Desarrollo en Odoo

## Objetivo
Con este repositorio se dispondrá de escenarios para realizar prácticas de desarrollo de Odoo en uno o varios docker container

## Escenarios
El escenario es el conjunto de elementos necesarios para la realización de la práctica. Consistirá en un conjunto de contenedores docker, uno o más, con funciones bien establecidas y descritas en la práctica. Tendrás que realizar los pasos indicados en la práctica en ellos, es decir serán la base de trabajo.

Este repositorio contiene los escenarios:

- **odoo-desarrollo**: Entorno docker compose de odoo para prácticas de desarrollo.

## Documentación (MkDocs)

Los contenidos teóricos de la unidad se publican como sitio MkDocs. Para verlos en local no hace falta instalar nada salvo Docker.

### Requisitos

- Docker y Docker Compose.
- Conexión a internet la primera vez, para descargar la imagen `python:3.12-slim` y los paquetes de MkDocs.

### Levantar el sitio

Desde la raíz de este repositorio:

```bash
docker compose up -d
```

Después abre en el navegador:

```text
http://127.0.0.1:8888
```

El servicio solo escucha en `127.0.0.1`, así que no es accesible desde otras máquinas.

### Seguir los mensajes del arranque

```bash
docker compose logs -f
```

Al arrancar, el contenedor instala `mkdocs`, `mkdocs-material` y `mkdocs-mermaid2-plugin`, y luego ejecuta `mkdocs serve`. Hasta que aparezca el aviso de servidor en marcha, el sitio no responde.

### Actualizar el contenido

Los archivos del repositorio se montan en el contenedor en solo lectura. Cuando se modifica un `.md` o `mkdocs.yml`, MkDocs recarga la página automáticamente. Si cambias el `docker-compose.yml`, vuelve a levantarlo:

```bash
docker compose up -d --force-recreate
```

### Parar el sitio

```bash
docker compose down
```

Este comando detiene y elimina el contenedor. El servicio tiene `restart: unless-stopped`, así que sin `docker compose down` volvería a arrancar tras reiniciar Docker.

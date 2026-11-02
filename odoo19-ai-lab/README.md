# Laboratorio Odoo 19 + IA

Plantilla docente para desarrollar módulos de Odoo 19 con un agente de programación desde Visual Studio Code.

## Inicio rápido

1. Clona este repositorio.
2. Copia `.env.example` a `.env` y ajusta `ODOO_SRC_HOST` a la ruta absoluta de tus fuentes (por defecto `~/odoo/src`).
3. Revisa `docker/docker-compose.yml` y adapta la imagen, puertos, nombre de base de datos y credenciales al Compose docente.
4. Completa `requirements/`.
5. Abre la carpeta raíz en Visual Studio Code.
6. Lee `AGENTS.md` y comienza por `context/tasks/01-exploracion.md`.

```bash
cp .env.example .env
# Editar ODOO_SRC_HOST si es necesario
docker compose -f docker/docker-compose.yml --env-file .env up -d
```

## Principios

- OCB/OCA se montan en solo lectura y no se modifican.
- El agente solo debe escribir dentro de `addons/`, `requirements/` y `docs/`, salvo autorización expresa.
- No se copia todo OCB/OCA al prompt. Se buscan archivos concretos y se incorporan referencias breves al contexto de la tarea.
- No se consideran correctos los cambios hasta probarlos en Odoo 19.

## Antes de usar

La configuración Docker incluida es una plantilla: adapta imagen, versión, servicio, base de datos y rutas al entorno real del centro. La carpeta de fuentes se monta para inspección; no implica que Odoo esté ejecutándose desde esos fuentes.

#!/usr/bin/env bash
set -euo pipefail
MODULE="${1:?Uso: $0 nombre_tecnico}"
DB="${ODOO_DB:-odoo19_lab}"
docker compose --env-file .env -f docker/docker-compose.yml exec odoo \
  odoo -d "$DB" -i "$MODULE" --stop-after-init --db_host=db \
  --db_user="${POSTGRES_USER:-odoo}" --db_password="${POSTGRES_PASSWORD:-odoo}"

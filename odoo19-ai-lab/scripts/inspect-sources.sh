#!/usr/bin/env bash
set -euo pipefail
SRC="${ODOO_SRC_HOST:?Define ODOO_SRC_HOST en .env}"
echo "Repositorios disponibles en: $SRC"
find "$SRC" -mindepth 1 -maxdepth 2 -type d -name .git -printf '%h\n' | sort

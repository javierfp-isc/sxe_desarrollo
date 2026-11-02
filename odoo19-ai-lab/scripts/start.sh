#!/usr/bin/env bash
set -euo pipefail
docker compose --env-file .env -f docker/docker-compose.yml up -d

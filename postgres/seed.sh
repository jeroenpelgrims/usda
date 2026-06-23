#!/bin/bash
set -euo pipefail

POSTGRES_USER="${POSTGRES_USER:-postgres}"
DB_NAME="${POSTGRES_DB:-$POSTGRES_USER}"

echo "Seeding PostgreSQL from SQLite: /data/usda.db"

pgloader -l /tmp/transforms.lisp /data/usda.load
# pgloader --on-error-stop \
#   sqlite:////data/usda.db \
#   "postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@/${DB_NAME}?host=/var/run/postgresql"

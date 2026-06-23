FROM postgres:18-bookworm

RUN apt-get update \
 && apt-get install -y --no-install-recommends pgloader \
 && rm -rf /var/lib/apt/lists/*

COPY ./out/usda.db /data/usda.db
RUN chmod 644 /data/usda.db
COPY ./postgres/seed.sh /docker-entrypoint-initdb.d/99_seed.sh
RUN chmod +x /docker-entrypoint-initdb.d/99_seed.sh

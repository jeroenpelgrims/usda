# Stage 1: Download & extract csv files
FROM alpine:3 AS csv
RUN apk add --no-cache curl grep sed

COPY download.sh /download.sh
RUN chmod +x /download.sh
RUN /download.sh

# Stage 2: Import csv files into sqlite database
FROM postgres:18

COPY --from=csv /foundation /foundation
COPY --from=csv /legacy /legacy
COPY seed.sql /docker-entrypoint-initdb.d/

# ENTRYPOINT sqlite3 /out/usda.db < /create-db.sql

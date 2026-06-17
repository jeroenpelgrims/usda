# Stage 1: Download & extract csv files
FROM alpine:3 AS csv
RUN apk add --no-cache curl grep sed

COPY download.sh /download.sh
RUN chmod +x /download.sh
RUN /download.sh

# Stage 2: Import csv files into sqlite database
FROM alpine/sqlite:3.53.2

COPY --from=csv /foundation /foundation
COPY --from=csv /legacy /legacy
COPY create-db.sh /create-db.sh
COPY *.sql /

RUN chmod +x /create-db.sh

ENTRYPOINT /create-db.sh

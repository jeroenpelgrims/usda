FROM alpine:3
RUN apk add --no-cache curl grep sed

COPY download.sh /download.sh
RUN chmod +x /download.sh

ENTRYPOINT ["/download.sh"]


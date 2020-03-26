FROM alpine:3

RUN apk update \
    && apk add --no-cache curl \
    && apk add --no-cache mysql-client \
    && apk add --no-cache postgresql-client \
    ; return 0

COPY docker-entrypoint.sh /
CMD /docker-entrypoint.sh

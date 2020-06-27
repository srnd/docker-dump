FROM node:12-alpine

ENV NODE_ENV production
RUN apk update \
    && npm install elasticdump -g \
    && apk add --no-cache curl \
    && apk add --no-cache mysql-client \
    && apk add --no-cache postgresql-client \
    ; return 0

COPY docker-entrypoint.sh /
CMD /docker-entrypoint.sh

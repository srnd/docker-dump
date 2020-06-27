#!/usr/bin/env sh

TIMESTAMP=$(date +%Y-%m-%d-%H-%M)

##########
# MySQL
##########
if [ ! -z "$MYSQL_USERNAME" ] && [ ! -z "$MYSQL_HOST" ]; then
  echo "Dumping mysql @ $MYSQL_HOST"
  mysqldump \
    -h "$MYSQL_HOST" \
    -u "$MYSQL_USERNAME" \
    --password="$MYSQL_PASSWORD" \
    --skip-lock-tables --quick --all-databases \
    > /dump/mysql-$TIMESTAMP.sql
fi

##########
# Postgres
##########
if [ ! -z "$PGSQL_USERNAME" ] && [ ! -z "$PGSQL_HOST" ]; then
  echo "Dumping postgres @ $PGSQL_HOST"
  # Set password file
  if [ ! -z "$PGSQL_PASSWORD" ]; then
    echo "*:*:*:*:$PGSQL_PASSWORD" > ~/.pgpass
    chmod 0600 ~/.pgpass
  fi

  pg_dumpall \
    -w \
    -h "$PGSQL_HOST" \
    -U "$PGSQL_USERNAME" \
    > /dump/pgsql-$TIMESTAMP.sql
fi

##########
# Elastic
##########

if [ ! -z "$ELASTIC_HOST" ]; then
  echo "Dumping Elastic @ $ELASTIC_HOST"
  elasticdump \
    --input=$ELASTIC_HOST \
    --output=/dump/elastic-$TIMESTAMP.json \
    --type=data
fi

#!/bin/bash

read -p "MySQL Host: " DB_HOST
read -p "MySQL Port: " DB_PORT
read -p "MySQL User: " DB_USER
read -s -p "MySQL Password ($DB_USER): " DB_PASS
echo
read -p "PostgreSQL Host: " PG_HOST
read -p "PostgreSQL Port: " PG_PORT
read -p "PostgreSQL User: " PG_USER
read -s -p "PostgreSQL Password ($PG_USER): " PG_PASS
echo
read -p "PostgreSQL DB: " IMPORT_DB

for db in odk_attic odk_prod
do
  psql $IMPORT_DB -c "set role rds_superuser; create schema if not exists $db;"
  pgloader --set search_path=\'$db\' \
    --before set-role-superuser.psql \
    mysql://$DB_USER:$DB_PASS@$DB_HOST:$DB_PORT/${db}_migrate \
    postgresql://$PG_USER:$PG_PASS@$PG_HOST:$PG_PORT/$IMPORT_DB
done


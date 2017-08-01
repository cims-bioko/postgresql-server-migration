#!/bin/bash

read -p "MySQL Host: " DB_HOST
read -p "MySQL Port: " DB_PORT
read -p "MySQL User: " DB_USER
read -s -p "MySQL Password ($DB_USER): " DB_PASS
read -p "PostgreSQL DB: " IMPORT_DB

for db in odk_attic odk_prod
do
  psql $IMPORT_DB -c "create schema $db"
  pgloader --set search_path=\'$db\' \
    mysql://$DB_USER:$DB_PASS@$DB_HOST:$DB_PORT/${db}_migrate \
    postgresql:///$IMPORT_DB
done


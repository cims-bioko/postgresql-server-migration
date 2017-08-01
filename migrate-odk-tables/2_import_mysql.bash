#!/bin/bash

read -p "MySQL Host: " DB_HOST
read -p "MySQL Port: " DB_PORT
read -p "MySQL User: " DB_USER
read -s -p "MySQL Password ($DB_USER): " DB_PASS



for db in odk_attic odk_prod
do
  IMPORT_DB=${db}_migrate
  mysql --host $DB_HOST --port $DB_PORT --user $DB_USER --password=$DB_PASS $IMPORT_DB <<SQL
create database $IMPORT_DB
SQL
  mysql --host $DB_HOST --port $DB_PORT --user $DB_USER --password=$DB_PASS $IMPORT_DB < ${db}.mysqldump
done


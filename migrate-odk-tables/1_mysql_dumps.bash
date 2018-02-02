#!/bin/bash

read -p "MySQL Host: " DB_HOST
read -p "MySQL Port: " DB_PORT
read -p "MySQL User: " DB_USER
read -s -p "MySQL Password ($DB_USER): " DB_PASS
echo

for db in odk_attic odk_prod
do
  mysqldump --host $DB_HOST --port $DB_PORT --user $DB_USER --password=$DB_PASS $db > ${db}.mysqldump
done

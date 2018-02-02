# CIMS Server PostgreSQL Migration

*This project is no longer active. With the successful migration of cims-server to PostgreSQL, this project exists only for archival purposes.*

This is an semi-automated migration tool for converting the openhds database
used by the cims-server program from MySQL to PostgreSQL. The original migration
was undertaken primarily in order to take advantage of the database's improved
programming features, better support for concurrency and schema management, and
mature support for GIS operations through the postgis module.

## Performing the migration 

The migration process consists of the following steps:

 * Generate an import script for the existing production data in MySQL
 * A psql command-line script for creating the new database and populating it
   with production data

The process was designed to work on a host other than the production server, so 
it uses SSH to dump and fetch the data from the production host. The psql script
is intended to work on the local host, after generating the import script.

To complete a migration:

```bash
# change to the root of the project directory (this one)
cd postgres-migration

# create a data import script from the existing production data
./create-import

# perform the migration on the local postgres database server
psql -f run-import.psql
```

The above assumes there is no existing database named 'openhds'. When the process
completes, a database named 'openhds' will exist within the local postgresql server
and will be populated with all of the existing production data.

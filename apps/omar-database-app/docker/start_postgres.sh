#!/bin/bash

DB_NAME=${POSTGRES_DB:-}
DB_USER=${POSTGRES_USER:-}
DB_PASS=${POSTGRES_PASSWORD:-}
SQL_SCRIPT=${OMAR_SQL_SCRIPT:-}
PG_CONFDIR="/var/lib/pgsql/9.4/data"

__create_user() {
  #Grant rights
  usermod -G wheel,adm postgres

  # Check to see if we have pre-defined credentials to use

if [ -n "${DB_USER}" ]; then
  if [ -z "${DB_PASS}" ]; then
    echo ""
    echo "WARNING: "
    echo "No password specified for \"${DB_USER}\". Generating one"
    echo ""
    DB_PASS=$(pwgen -c -n -1 12)
    echo "Password for \"${DB_USER}\" created as: \"${DB_PASS}\""
  fi
    echo "Creating user \"${DB_USER}\"..."
    echo "CREATE ROLE ${DB_USER} with CREATEROLE login superuser PASSWORD '${DB_PASS}';" |
      sudo -u postgres -H /usr/pgsql-9.4/bin/postgres --single \
       -c config_file=${PG_CONFDIR}/postgresql.conf -D ${PG_CONFDIR}

fi

if [ -n "${DB_NAME}" ]; then
  echo "Creating database \"${DB_NAME}\"..."
  echo "CREATE DATABASE ${DB_NAME};" | \
    sudo -u postgres -H /usr/pgsql-9.4/bin/postgres --single \
     -c config_file=${PG_CONFDIR}/postgresql.conf -D ${PG_CONFDIR}

  if [ -n "${DB_USER}" ]; then
    echo "Granting access to database \"${DB_NAME}\" for user \"${DB_USER}\"..."
    echo "GRANT ALL PRIVILEGES ON DATABASE ${DB_NAME} to ${DB_USER};" |
      sudo -u postgres -H /usr/pgsql-9.4/bin/postgres --single \
      -c config_file=${PG_CONFDIR}/postgresql.conf -D ${PG_CONFDIR}
  fi

  sleep 5

  if [ -n "${SQL_SCRIPT}" ]; then
    echo "Running SQL script \"${SQL_SCRIPT}\" on Database \"${DB_NAME}\" for user \"${DB_USER}\"..."
    sudo -u postgres -H psql -U ${DB_USER} -d ${DB_NAME} -f ${SQL_SCRIPT}
  fi
fi
}


__run_supervisor() {
supervisord -n
}

# Call all functions
__create_user
__run_supervisor


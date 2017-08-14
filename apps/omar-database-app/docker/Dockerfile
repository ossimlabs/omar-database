# This image conducts a postgresql installation from
# postgres:latest.  It then installs the PostGIS spatial
# extension for Postgres.  It also adds the postgis
# extension to the specified database.
FROM docker-registry-default.ossim.io/o2/omar-base:latest
MAINTAINER RadiantBlue Technologies radiantblue.com
LABEL com.radiantblue.version="0.1"\
      com.radiantblue.description="This image conducts \
      a postgresql installation from postgres:latest. \
      It then installs the PostGIS spatial extension for \
      Postgres. It also adds the postgis extension to the \
      specified database."\
      com.radiantblue.source=""\
      com.radiantblue.classification="UNCLASSIFIED"

USER root

ENV POSTGRES_DB o2_omar_db
ENV POSTGRES_USER postgres

RUN yum install https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-redhat96-9.6-3.noarch.rpm && \
yum -y install postgresql96 postgresql96-server postgresql96-contrib postgis2_96 && \
/usr/pgsql-9.6/bin/postgresql96-setup initdb && \
systemctl enable postgresql-9.6 && \
systemctl start postgresql-9.6

USER postgres

RUN createdb $POSTGRES_DB && \
psql -d $POSTGRES_DB -v ON_ERROR_STOP=1 --username $POSTGRES_USER -c "CREATE EXTENSION postgis"

ADD omardb.sql omardb.sql
RUN psql -d $POSTGRES_DB -f omardb.sql

CMD "postgres"

EXPOSE 5432
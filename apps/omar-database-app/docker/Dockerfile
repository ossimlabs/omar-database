# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM omar-base:latest
MAINTAINER DigitalGlobe-RadiantBlue

RUN yum -y update; yum clean all
RUN wget https://download.postgresql.org/pub/repos/yum/9.4/redhat/rhel-7-x86_64/pgdg-redhat94-9.4-3.noarch.rpm && \
         rpm -ivh pgdg-redhat94-9.4-3.noarch.rpm
RUN yum -y install sudo postgresql94-server postgresql94 postgresql94-contrib postgis22_94 proj-epsg proj-nad supervisor pwgen; yum clean all

ADD ./postgresql-setup /usr/bin/postgresql-setup
ADD ./supervisord.conf /etc/supervisord.conf
ADD ./start_postgres.sh /start_postgres.sh

#Sudo requires a tty. fix that.
RUN sed -i 's/.*requiretty$/#Defaults requiretty/' /etc/sudoers
RUN chmod +x /usr/bin/postgresql-setup
RUN chmod +x /start_postgres.sh

RUN /usr/bin/postgresql-setup initdb

ADD ./postgresql.conf /var/lib/pgsql/9.4/data/postgresql.conf

RUN chown -v postgres.postgres /var/lib/pgsql/9.4/data/postgresql.conf

RUN echo "host    all             all             0.0.0.0/0               trust" >> /var/lib/pgsql/9.4/data/pg_hba.conf

ADD ./omardb.sql /var/lib/pgsql/9.4/data/omardb.sql

RUN createdb --username=postgres o2_omar_db

RUN psql -U postgres -d o2_omar_db -a -f omardb.sql

VOLUME ["/var/lib/pgsql"]

EXPOSE 5432

CMD ["/bin/bash", "/start_postgres.sh"]

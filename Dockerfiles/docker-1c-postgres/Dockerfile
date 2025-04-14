FROM ubuntu:22.04

MAINTAINER Vadim Gurko <VA.Gurko@yandex.ru>

ARG SERVER_VERSION=16
ARG GOSU_VERSION=1.17

ENV TZ=Europe/Moscow \
    DEBIAN_FRONTEND=noninteractive \
    TERM=xterm \
    LANGUAGE=ru_RU.UTF-8 \
    #LC_ALL=C \
    LANG=ru_RU.UTF-8 \
    PATH=/opt/pgpro/1c-${SERVER_VERSION}/bin:$PATH \
    LD_LIBRARY_PATH=/opt/pgpro/1c-${SERVER_VERSION}/lib \
    PGDATA=/opt/pgpro/data \
    PGUSER=postgres

RUN ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \
    apt-get -qq update && \
    apt-get -qq install --yes --no-install-recommends ca-certificates wget locales apt-utils mc htop sudo perl && \
    localedef --inputfile en_US --force --charmap UTF-8 en_US.UTF-8 && \
    localedef --inputfile ru_RU --force --charmap UTF-8 ru_RU.UTF-8 && \
    wget --quiet -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64" && \
    chmod +x /usr/local/bin/gosu && \
    wget --quiet https://repo.postgrespro.ru/1c/1c-$SERVER_VERSION/keys/pgpro-repo-add.sh -O /tmp/pgpro-repo-add.sh && \
    sh /tmp/pgpro-repo-add.sh && \
    apt-get -y install postgrespro-1c-$SERVER_VERSION && \
    #apt-get -y install postgrespro-1c-$SERVER_VERSION-server postgrespro-1c-$SERVER_VERSION-contrib && \
    wget --quiet -O /usr/bin/pgcompacttable "https://raw.githubusercontent.com/dataegret/pgcompacttable/master/bin/pgcompacttable" && \
    chmod +x /usr/bin/pgcompacttable && \
    wget --quiet -O /tmp/pgcenter_0.9.2_linux_amd64.deb "https://github.com/lesovsky/pgcenter/releases/download/v0.9.2/pgcenter_0.9.2_linux_amd64.deb" && \
    apt install -y /tmp/pgcenter_0.9.2_linux_amd64.deb && \
    apt-get clean && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY container/docker-entrypoint.sh /

RUN chmod 755 /docker-entrypoint.sh && \
    chmod +x /docker-entrypoint.sh && \
    mkdir --parent /var/run/postgresql /opt/pgpro/1C /opt/pgpro/1C/data /opt/pgpro/1C/index /docker-entrypoint-initdb.d /docker-entrypoint-startdb.d && \
    ln -s /tmp/pgpro/temp/ /opt/pgpro/1C && \
    chown --recursive postgres:postgres /var/run/postgresql /opt/pgpro/1C && \
    chmod g+s /var/run/postgresql && \
    ln -s $PGDATA/pg_log /var/log/pgpro

COPY container/init-temp.sh /docker-entrypoint-startdb.d/
COPY container/init-getconfig.sh /docker-entrypoint-initdb.d/

VOLUME $PGDATA /opt/pgpro/1C/data /opt/pgpro/1C/index
EXPOSE 5432
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["postgres"]

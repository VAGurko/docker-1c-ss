FROM ubuntu:24.04

MAINTAINER Vadim Gurko <VA.Gurko@yandex.ru>

ENV GOSU_VERSION 1.17
ENV TTF_PACKAGE ttf-mscorefonts-installer_3.8.1_all.deb
RUN apt-get -qq update \
  && apt-get -qq upgrade --yes \
  && apt-get -qq install --yes --no-install-recommends ca-certificates wget locales apt-utils \
  && `#----- Install the dependencies -----` \
  && apt-get -qq install --yes --no-install-recommends fontconfig imagemagick libfreetype6 libgsf-1-common libgssapi-krb5-2 unixodbc \
  && `#----- Deal with ttf-mscorefonts-installer -----` \
  && apt-get -qq install --yes --no-install-recommends xfonts-utils cabextract \
  && rm -rf /var/lib/apt/lists/* \
  && wget --quiet --output-document /tmp/$TTF_PACKAGE http://ftp.us.debian.org/debian/pool/contrib/m/msttcorefonts/$TTF_PACKAGE \
  && dpkg --install /tmp/$TTF_PACKAGE 2> /dev/null \
  && rm /tmp/$TTF_PACKAGE \
  && `#----- Install gosu -----` \
  && wget --quiet --output-document /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
  && chmod +x /usr/local/bin/gosu \
  && gosu --version \
  && gosu nobody true

RUN localedef --inputfile ru_RU --force --charmap UTF-8 --alias-file /usr/share/locale/locale.alias ru_RU.UTF-8
ENV LANG ru_RU.utf8

#RUN apt-get -qq install --yes --no-install-recommends ttf-mscorefonts-installer
#RUN fc-cache -fv
#RUN apt-get -qq install --yes --no-install-recommends libfreetype6 libgsf-1-common unixodbc glib2.0

ADD deb/*.deb /tmp/
ENV PLATFORM=8.3.25
ENV RELEASE=1394
RUN groupadd \
      --system \
      --gid 999 \
      grp1cv8 && \
    useradd \
      --system \
      --comment "1C system user" \
      -g grp1cv8 \
      --uid 999 \
      --shell /sbin/nologin \
      --home-dir /home/usr1cv8/ \
      usr1cv8 && \
    mkdir --parents /var/log/1C /home/usr1cv8/.1cv8/1C/1cv8/conf && \
    chown --recursive usr1cv8:grp1cv8 /var/log/1C /home/usr1cv8 && \
    dpkg --install /tmp/1c-enterprise-${PLATFORM}.${RELEASE}-common_${PLATFORM}-${RELEASE}_*.deb 2> /dev/null && \
    dpkg --install /tmp/1c-enterprise-${PLATFORM}.${RELEASE}-server_${PLATFORM}-${RELEASE}_*.deb 2> /dev/null && \
    dpkg --install /tmp/1c-enterprise-${PLATFORM}.${RELEASE}-ws_${PLATFORM}-${RELEASE}_*.deb 2> /dev/null && \
    dpkg --install /tmp/1c-enterprise-${PLATFORM}.${RELEASE}-crs_${PLATFORM}-${RELEASE}_*.deb 2> /dev/null && \
    rm /tmp/*.deb && \
    ln -s /opt/1cv8/x86_64/${PLATFORM}.${RELEASE}/ibcmd /usr/bin/ibcmd && \
    ln -s /opt/1cv8/x86_64/${PLATFORM}.${RELEASE}/ibsrv /usr/bin/ibsrv

COPY container/docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

VOLUME /home/usr1cv8
VOLUME /opt/1cv8/conf

EXPOSE 8314 1540-1541 1560-1591

CMD ["ibsrv"]

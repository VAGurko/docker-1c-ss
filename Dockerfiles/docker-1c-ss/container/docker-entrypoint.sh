#!/bin/bash
ARH=x86_64
PLATFORM=8.3.25
RELEASE=1394

if [[ ! -d /home/usr1cv8/.1cv8 ]]; then
  exec mkdir --parent "/home/usr1cv8/.1cv8" && \
  chown --recursive usr1cv8:grp1cv8 /home/usr1cv8/
  else
    chown --recursive usr1cv8:grp1cv8 /home/usr1cv8/
fi

if [[ "$1" = "ibsrv" && -f /opt/1cv8/conf/config.yml ]]; then
  exec gosu usr1cv8 /opt/1cv8/${ARH}/${PLATFORM}.${RELEASE}/ibsrv --config=/opt/1cv8/conf/config.yml
  else
    if [ "$1" = "ibsrv" ]; then
      exec gosu usr1cv8 /opt/1cv8/${ARH}/${PLATFORM}.${RELEASE}/ibsrv
    fi
fi

exec "$@"

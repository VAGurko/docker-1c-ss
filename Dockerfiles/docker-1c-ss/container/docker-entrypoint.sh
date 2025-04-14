#!/bin/bash

if [[ ! -d /home/usr1cv8/.1cv8 ]]; then
  exec mkdir --parent "/home/usr1cv8/.1cv8" && \
  chown --recursive usr1cv8:grp1cv8 /home/usr1cv8/
  else
    chown --recursive usr1cv8:grp1cv8 /home/usr1cv8/
fi

if [[ "$1" = "ibsrv" && -f /opt/1cv8/conf/config.yml ]]; then
  exec gosu usr1cv8 /opt/1cv8/x86_64/8.3.25.1394/ibsrv --config=/opt/1cv8/conf/config.yml
  else
    if [ "$1" = "ibsrv" ]; then
      exec gosu usr1cv8 /opt/1cv8/x86_64/8.3.25.1394/ibsrv
    fi
fi

exec "$@"

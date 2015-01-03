#!/bin/bash

LOG_LEVEL=${LOG_LEVEL-2}
if [ "X${VDR_DEVICE}" != "X" ];then
    DEV="--device ${VDR_DEVICE}"
else
    DEV=""
fi

vdr -v /video -c /etc/vdr -s -E /var/cache/vdr/epg.data -u root ${DEV} --log=${LOG_LEVEL} \
    --port 6419 --dirnames=,,1 -w 60 -P epgsearchonly -P streamdev-server -P vnsiserver -P epgsearch 

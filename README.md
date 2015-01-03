# Start

The most fun it's going to be if one uses pipework to pin a dedicated IP to the vdr instance.
I use docker-spotter for that purpose, delicious...

```
docker run -d --privileged --name vdr -h vdr -v /boedde/video:/video -e VDR_DEVICE=1 -e LOG_LEVEL=1 --net=none qnib/vdr
```

The following environment variables are useable:

- ```VDR_DEVICE```: In cases where multiple devices are available this variable limits the use. Comes in handy to split between production and development instance.
- ```LOG_LEVEL```: Restricts the output of the vdr process (0 = no logging, 1 = errors only, 2 = errors and info, 3 = errors, info and debug)

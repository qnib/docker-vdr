###### Supervisord image
FROM qnib/supervisor
MAINTAINER "Christian Kniep <christian@qnib.org>"

ADD etc/yum.repos.d/qnib_fd20.repo /etc/yum.repos.d/qnib_fd20.repo

RUN groupdel video; groupadd -g 44 video
RUN useradd -u 1000 vdr
RUN yum install -y vdr vdr-streamdev-server vdr-epgsearch vdr-vnsiserver5 

RUN yum install -y vdradmin-am

ENV LANG de_DE.UTF-8

## channels
ADD etc/vdr/plugins/vnsiserver/allowed_hosts.conf /etc/vdr/plugins/vnsiserver/allowed_hosts.conf
ADD etc/supervisord.d/vdr.ini /etc/supervisord.d/vdr.ini
ADD etc/supervisord.d/vdradmin.ini /etc/supervisord.d/vdradmin.ini

ADD etc/vdr/setup.conf /etc/vdr/setup.conf
ADD etc/vdr/channels.conf /etc/vdr/channels.conf

ADD opt/qnib/bin/start_vdr.sh /opt/qnib/bin/start_vdr.sh

CMD [ "supervisord", "-c", "/etc/supervisord.conf" ]


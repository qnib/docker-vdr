###### Supervisord image
FROM qnib/consul:fd22

RUN groupdel video; groupadd -g 44 video
RUN useradd -u 1000 vdr
RUN dnf install -y vdr vdr-streamdev-server vdr-epgsearch vdr-vnsiserver

#RUN dnf install -y vdradmin-am

ENV LANG de_DE.UTF-8

## channels
ADD etc/supervisord.d/vdr.ini /etc/supervisord.d/vdr.ini
#ADD etc/supervisord.d/vdradmin.ini /etc/supervisord.d/vdradmin.ini

RUN mkdir -p /opt/vdr/
# vnsiserver
ADD opt/vdr/plugins/vnsiserver/allowed_hosts.conf /opt/vdr/plugins/vnsiserver/allowed_hosts.conf
RUN rm -rf /etc/vdr/plugins/vnsiserver; ln -s /opt/vdr/plugins/vnsiserver /etc/vdr/plugins/vnsiserver
# epgsearch
ADD opt/vdr/plugins/epgsearch/ /opt/vdr/plugins/epgsearch/
RUN rm -rf /var/lib/vdr/data/epgsearch; ln -s /opt/vdr/plugins/epgsearch /var/lib/vdr/data/epgsearch
# vdr-config
ADD opt/vdr/conf/setup/setup.conf /opt/vdr/conf/setup/
RUN rm -f /etc/vdr/setup.conf;ln -s /opt/vdr/conf/setup/setup.conf /etc/vdr/
ADD opt/vdr/conf/channels/channels.conf /opt/vdr/conf/channels/
RUN rm -f /etc/vdr/channels.conf;ln -s /opt/vdr/conf/channels/channels.conf /etc/vdr/
ADD opt/vdr/conf/timers/timers.conf /opt/vdr/conf/timers/
RUN rm -f /etc/vdr/timers.conf;ln -s /opt/vdr/conf/timers/timers.conf /etc/vdr/

ADD opt/qnib/bin/start_vdr.sh /opt/qnib/bin/start_vdr.sh

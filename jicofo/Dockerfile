FROM phusion/baseimage:0.9.22

ARG REPOSITORY=stable

RUN curl -LSs https://download.jitsi.org/jitsi-key.gpg.key | apt-key add - && \
    echo "deb https://download.jitsi.org $REPOSITORY/" > /etc/apt/sources.list.d/jitsi-$REPOSITORY.list && \
    DEBIAN_FRONTEND=noninteractive apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        jicofo && \
    mkdir -p /etc/service/jicofo && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY jicofo.sh /etc/service/jicofo/run
COPY finish.sh /etc/service/jicofo/finish
RUN chmod a+x /etc/service/jicofo/run /etc/service/jicofo/finish

CMD ["/sbin/my_init"]

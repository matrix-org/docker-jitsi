FROM phusion/baseimage:0.9.22

RUN curl -LSs https://download.jitsi.org/jitsi-key.gpg.key | apt-key add - && \
    echo "deb https://download.jitsi.org stable/" > /etc/apt/sources.list.d/jitsi-stable.list && \
    DEBIAN_FRONTEND=noninteractive apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        jitsi-videobridge && \
    mkdir -p /etc/service/videobridge && \
    mkdir -p /etc/my_init.d && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY videobridge.sh /etc/service/videobridge/run
COPY finish.sh /etc/service/videobridge/finish
COPY sip-communicator.properties.sh /etc/my_init.d/sip-communicator.properties.sh
RUN chmod a+x \
    /etc/service/videobridge/run \
    /etc/service/videobridge/finish \
    /etc/my_init.d/sip-communicator.properties.sh

CMD ["/sbin/my_init"]

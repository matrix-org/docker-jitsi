#! /bin/bash

ARGS=""

if [[ -n "$XMPP_HOST" ]]; then
    ARGS="$ARGS --host=$XMPP_HOST"
else
    ARGS="$ARGS --host=localhost"
fi

if [[ -n "$XMPP_PORT" ]]; then
    ARGS="$ARGS --port=$XMPP_PORT"
else
    ARGS="$ARGS --port=5347"
fi

if [[ -n "$XMPP_DOMAIN" ]]; then
    ARGS="$ARGS --domain=$XMPP_DOMAIN"
else
    echo "XMPP_DOMAIN must be set"
    exit 1
fi

if [[ -n "$VIDEOBRIDGE_XMPP_SUBDOMAIN" ]]; then
    ARGS="$ARGS --subdomain=$VIDEOBRIDGE_XMPP_SUBDOMAIN"
else
    ARGS="$ARGS --subdomain=videobridge"
fi

if [[ -n "$VIDEOBRIDGE_XMPP_SECRET" ]]; then
    ARGS="$ARGS --secret=$VIDEOBRIDGE_XMPP_SECRET"
else
    echo "VIDEOBRIDGE_XMPP_SECRET must be set"
    exit 1
fi

if [[ -n "$VIDEOBRIDGE_MIN_PORT" ]]; then
    ARGS="$ARGS --min-port=$VIDEOBRIDGE_MIN_PORT"
else
    ARGS="$ARGS --min-port=49152"
fi

if [[ -n "$VIDEOBRIDGE_MAX_PORT" ]]; then
    ARGS="$ARGS --max-port=$VIDEOBRIDGE_MAX_PORT"
else
    ARGS="$ARGS --max-port=65535"
fi

if [[ -n "$VIDEOBRIDGE_APIS" ]]; then
    ARGS="$ARGS --apis=$VIDEOBRIDGE_APIS"
fi

echo "Executing: jvb.sh $ARGS"
JAVA_SYS_PROPS="-Dnet.java.sip.communicator.SC_HOME_DIR_LOCATION=/etc/jitsi -Dnet.java.sip.communicator.SC_HOME_DIR_NAME=videobridge -Dnet.java.sip.communicator.SC_LOG_DIR_LOCATION=/var/log/jitsi -Djava.util.logging.config.file=/etc/jitsi/videobridge/logging.properties" exec /sbin/setuser jvb /usr/share/jitsi-videobridge/jvb.sh $ARGS

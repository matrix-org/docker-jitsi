#!/bin/bash

PROPERTIES_FILE=/etc/jitsi/videobridge/sip-communicator.properties
echo "org.jitsi.impl.neomedia.transform.srtp.SRTPCryptoContext.checkReplay=false" > \
    $PROPERTIES_FILE
echo "org.jitsi.videobridge.AUTHORIZED_SOURCE_REGEXP=focus@auth.${XMPP_DOMAIN}/.*" >> \
    $PROPERTIES_FILE
echo "org.jitsi.videobridge.SINGLE_PORT_HARVESTER_PORT=${VIDEOBRIDGE_MAX_PORT}" >> \
    $PROPERTIES_FILE

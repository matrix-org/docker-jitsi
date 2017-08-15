#!/bin/bash
#
# Copyright 2017 Vector Creations Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PROPERTIES_FILE=/etc/jitsi/videobridge/sip-communicator.properties
echo "org.jitsi.impl.neomedia.transform.srtp.SRTPCryptoContext.checkReplay=false" > \
    $PROPERTIES_FILE
echo "org.jitsi.videobridge.AUTHORIZED_SOURCE_REGEXP=focus@auth.${XMPP_DOMAIN}/.*" >> \
    $PROPERTIES_FILE

if [[ -n "$VIDEOBRIDGE_MAX_PORT" ]]; then
    echo "org.jitsi.videobridge.SINGLE_PORT_HARVESTER_PORT=${VIDEOBRIDGE_MAX_PORT}" >> \
        $PROPERTIES_FILE
else
    echo "org.jitsi.videobridge.SINGLE_PORT_HARVESTER_PORT=65535" >> \
        $PROPERTIES_FILE
fi

if [[ -n "$VIDEOBRIDGE_TCP_PORT" ]]; then
    echo "org.jitsi.videobridge.TCP_HARVESTER_PORT=${VIDEOBRIDGE_TCP_PORT}" >> \
        $PROPERTIES_FILE
fi
if [[ -n "$VIDEOBRIDGE_TCP_EXTERNAL_PORT" ]]; then
    echo "org.jitsi.videobridge.TCP_HARVESTER_MAPPED_PORT=${VIDEOBRIDGE_TCP_EXTERNAL_PORT}" >> \
        $PROPERTIES_FILE
fi
if [[ -n "$VIDEOBRIDGE_SSLTCP" ]]; then
    echo "org.jitsi.videobridge.TCP_HARVESTER_SSLTCP=${VIDEOBRIDGE_SSLTCP}" >> \
        $PROPERTIES_FILE
else
    echo "org.jitsi.videobridge.TCP_HARVESTER_SSLTCP=false" >> \
        $PROPERTIES_FILE
fi
if [[ -n "$VIDEOBRIDGE_ALLOWED_ADDRESSES" ]]; then
    echo "org.jitsi.videobridge.ALLOWED_ADDRESSES=${VIDEOBRIDGE_ALLOWED_ADDRESSES}" >> \
        $PROPERTIES_FILE
fi

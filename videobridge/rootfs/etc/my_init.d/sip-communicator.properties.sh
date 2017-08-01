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
echo "org.jitsi.videobridge.SINGLE_PORT_HARVESTER_PORT=${VIDEOBRIDGE_MAX_PORT}" >> \
    $PROPERTIES_FILE

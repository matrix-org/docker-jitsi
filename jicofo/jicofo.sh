#! /bin/bash
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

if [[ -n "$JICOFO_XMPP_FOCUS_SUBDOMAIN" ]]; then
    ARGS="$ARGS --subdomain=$JICOFO_XMPP_FOCUS_SUBDOMAIN"
else
    ARGS="$ARGS --subdomain=focus"
fi

if [[ -n "$JICOFO_XMPP_FOCUS_SECRET" ]]; then
    ARGS="$ARGS --secret=$JICOFO_XMPP_FOCUS_SECRET"
else
    echo "JICOFO_XMPP_FOCUS_SECRET must be set"
    exit 1
fi

if [[ -n "$JICOFO_XMPP_FOCUS_USER_DOMAIN" ]]; then
    ARGS="$ARGS --user_domain=$JICOFO_XMPP_FOCUS_USER_DOMAIN"
else
    ARGS="$ARGS --user_domain=auth.$XMPP_DOMAIN"
fi

if [[ -n "$JICOFO_XMPP_FOCUS_USER_NAME" ]]; then
    ARGS="$ARGS --user_name=$JICOFO_XMPP_FOCUS_USER_NAME"
else
    ARGS="$ARGS --user_name=focus"
fi

if [[ -n "$JICOFO_XMPP_FOCUS_USER_PASSWORD" ]]; then
    ARGS="$ARGS --user_password=$JICOFO_XMPP_FOCUS_USER_PASSWORD"
else
    echo "JICOFO_XMPP_FOCUS_USER_PASSWORD must be set"
    exit 1
fi

echo "Executing: jicofo.sh $ARGS"
JAVA_SYS_PROPS="-Dnet.java.sip.communicator.SC_HOME_DIR_LOCATION=/etc/jitsi -Dnet.java.sip.communicator.SC_HOME_DIR_NAME=jicofo -Dnet.java.sip.communicator.SC_LOG_DIR_LOCATION=/var/log/jitsi -Djava.util.logging.config.file=/etc/jitsi/jicofo/logging.properties" exec /sbin/setuser jicofo /usr/share/jicofo/jicofo.sh $ARGS

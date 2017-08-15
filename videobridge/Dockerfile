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

FROM phusion/baseimage:0.9.22

ARG REPOSITORY=stable
ARG VIDEOBRIDGE_VERSION=*

RUN curl -LSs https://download.jitsi.org/jitsi-key.gpg.key | apt-key add - && \
    echo "deb https://download.jitsi.org $REPOSITORY/" > /etc/apt/sources.list.d/jitsi-$REPOSITORY.list && \
    DEBIAN_FRONTEND=noninteractive apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        jitsi-videobridge="$VIDEOBRIDGE_VERSION" && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY rootfs /

CMD ["/sbin/my_init"]

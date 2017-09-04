# Jitsi videobridge docker image

* `XMPP_HOST` - sets the hostname of the XMPP server (default: localhost)
* `XMPP_PORT` - sets the port of the XMPP server (default: 5347)
* REQUIRED: `XMPP_DOMAIN` - sets the XMPP domain (default: none)
* REQUIRED: `VIDEOBRIDGE_XMPP_SECRET` - sets the shared secret used to authenticate to the XMPP server
* `VIDEOBRIDGE_MIN_PORT` - sets the min port used for media (default: 49152)
* `VIDEOBRIDGE_MAX_PORT` - sets the max port used for media (default: 65535)
* `VIDEOBRIDGE_XMPP_SUBDOMAIN` - sets the sub-domain used to bind JVB XMPP component (default: videobridge)
* `VIDEOBRIDGE_APIS` - where APIS is a comma separated list of APIs to enable. Currently supported APIs are 'xmpp' and 'rest'. The default is 'xmpp'.
* `VIDEOBRIDGE_TCP_PORT` - the TCP port bound by videobridge for TCP candidates (default: 443)
* `VIDEOBRIDGE_TCP_EXTERNAL_PORT` - the external TCP port advertised in TCP candidates (default: 443)
* `VIDEOBRIDGE_SSLTCP` - whether to expect a TLS handshake at the beginning of communications on the TCP listener [proprietary mechanism to fool proxies, supported in Chrome] (default: false) **NOTE**: will **only** advertise `ssltcp` candidates and not `tcp` candidates if this is enabled which may be undesirable.
* `VIDEOBRIDGE_ALLOWED_ADDRESSES` - a comma-separated list of allowed addresses to be advertised in ICE candidates by the videobridge. (default: "")
* `VIDEOBRIDGE_CALLSTATS_APPID` - callstats.io app ID for stats reporting
* `VIDEOBRIDGE_CALLSTATS_APPSECRET` - callstats.io app secret for stats reporting
* `VIDEOBRIDGE_CALLSTATS_BRIDGEID` - a string identifying this specific videobridge


**Note:** Run the container with `--net=host` so that the UDP media ports specified by `VIDEOBRIDGE_MIN_PORT` and `VIDEOBRIDGE_MAX_PORT` are accessible. Docker is not yet good at mapping wide ranges of UDP ports from a host to a container. Alternatively, expose `VIDEOBRIDGE_TCP_PORT` and `VIDEOBRIDGE_MAX_PORT`. Jitsi videobridge can handle many UDP clients on a single port which is configured to use `VIDEOBRIDGE_MAX_PORT` in this image.

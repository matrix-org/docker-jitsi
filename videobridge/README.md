# Jitsi videobridge docker image

* `XMPP_HOST` - sets the hostname of the XMPP server (default: localhost)
* `XMPP_PORT` - sets the port of the XMPP server (default: 5347)
* REQUIRED: `XMPP_DOMAIN` - sets the XMPP domain (default: none)
* REQUIRED: `VIDEOBRIDGE_XMPP_SECRET` - sets the shared secret used to authenticate to the XMPP server
* `VIDEOBRIDGE_MIN_PORT` - sets the min port used for media (default: 49152)
* `VIDEOBRIDGE_MAX_PORT` - sets the max port used for media (default: 65535)
* `VIDEOBRIDGE_XMPP_SUBDOMAIN` - sets the sub-domain used to bind JVB XMPP component (default: videobridge)
* `VIDEOBRIDGE_APIS` - where APIS is a comma separated list of APIs to enable. Currently supported APIs are 'xmpp' and 'rest'. The default is 'xmpp'.

**Note:** Run the container with `--net=host` so that the UDP media ports specified by `VIDEOBRIDGE_MIN_PORT` and `VIDEOBRIDGE_MAX_PORT` are accessible. Docker is not yet good at mapping wide ranges of UDP ports from a host to a container.

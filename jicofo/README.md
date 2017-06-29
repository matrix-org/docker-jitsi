# Jitsi jicofo docker image

* `XMPP_HOST` - sets the hostname of the XMPP server (default: domain, if domain is set, localhost otherwise)
* `XMPP_PORT` - sets the port of the XMPP server (default: 5347)
* REQUIRED: `XMPP_DOMAIN` - sets the XMPP domain
* `JICOFO_XMPP_FOCUS_SUBDOMAIN` - sets the sub-domain used to bind focus XMPP component (default: focus)
* REQUIRED: `JICOFO_XMPP_FOCUS_SECRET` - sets the shared secret used to authenticate focus component to the XMPP server
* `JICOFO_XMPP_FOCUS_USER_DOMAIN` - specifies the name of XMPP domain used by the focus user to login. (default: `auth.$XMPP_DOMAIN`)
* `JICOFO_XMPP_FOCUS_USER_NAME` - specifies the username used by the focus XMPP user to login. (default: focus)
* REQUIRED: `JICOFO_XMPP_FOCUS_USER_PASSWORD` - specifies the password used by focus XMPP user to login. If not provided then focus user will use anonymous authentication method.

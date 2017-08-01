# Jitsi Meet in docker

Implemented based on https://github.com/jitsi/jitsi-meet/blob/master/doc/manual-install.md

## Images

* prosody - official image
* nginx - official image
* jicofo and videobridge - custom in-tree, based on phusion/baseimage

## Configuration

The files in `config/` and the `docker-compose.yaml` file will need modifying if you wish to use this for a real deployment.

### Secrets

Choose three distinct secrets (passwords) and respectively replace all instances of YOURSECRET1, YOURSECRET2 and YOURSECRET3 with them.

### Domain

Choose a base domain (e.g. jitsi.example.com). Replace "prosody" with your base domain in all the cases below:

`config/config.js`:
```
domain: 'prosody',
bridge: 'videobridge.prosody',
anonymousdomain: 'guest.prosody',
//authdomain: 'prosody',  // defaults to <domain>
muc: 'conference.prosody', // FIXME: use XEP-0030
//jirecon: 'jirecon.prosody',
//call_control: 'callcontrol.prosody',
focus: 'focus.prosody', // defaults to 'focus.jitsi-meet.example.com'
focusUserJid: 'focus@auth.prosody', // The real JID of focus participant - can be overridden here
```

`config/default.conf`:
(Note: also change "localhost" here)
```
server_name localhost;
proxy_set_header Host "prosody";
```

`config/prosody.cfg.lua`:
```
admins = { "focus@auth.prosody" }
VirtualHost "prosody"
VirtualHost "auth.prosody"
VirtualHost "guest.prosody"
Component "conference.prosody" "muc"
Component "videobridge.prosody"
Component "focus.prosody"
```

`docker-compose.yaml`:
```
services:
    prosody:
        environment:
            DOMAIN: auth.prosody
    jicofo:
        environment:
            XMPP_DOMAIN: prosody
    videobridge:
        environment:
            XMPP_DOMAIN: prosody
```

## Ports bound on host

* nginx
    * 9090 - HTTP for jitsi-meet web client
* prosody
    * 5347 - prosody component port, used by videobridge. Don't expose to the world.
* jitsi-videobridge
    * 4443/tcp - WebRTC over TCP/TLS for corporate firewalls blocking UDP traffic
    * 49152-65535/udp - WebRTC, dynamically bound as needed and available

**NOTE**: jitsi-videobridge is run using `network_mode: host` so that UDP traffic in the configured range can flow properly.

## Running

```
docker-compose -p jitsi build
docker-compose -p jitsi up -d
```

## License

Apache License, Version 2.0. See the LICENSE file for more details.

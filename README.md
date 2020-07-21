# Jitsi Meet in docker

Implemented based on [Jitsi Meet manual installation instructions](https://jitsi.github.io/handbook/docs/devops-guide/devops-guide-manual).

## Images

* prosody - [official image](https://hub.docker.com/r/prosody/prosody/)
* nginx - [official image](https://hub.docker.com/_/nginx/)
* jicofo and videobridge - custom in-tree, based on [phusion/baseimage](https://github.com/phusion/baseimage-docker)

## jitsi-meet

Clone and prepare the [jitsi-meet web repository](https://github.com/jitsi/jitsi-meet) alongside the `docker-jitsi` directory. It is mounted as a volume into the nginx container to be served.

That is from the directory where this README.md file is:
```
cd ..

git clone git@github.com:jitsi/jitsi-meet.git

cd jitsi-meet
npm install && make

cd ../docker-jitsi
```

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
**NOTE:** `config/config.js` is from the jitsi-meet repository. If you prefer, you can modify `docker-compose.yaml` to not mount in `config/config.js` and instead modify the config.js in-place in your jitsi-meet clone.

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
    * 5347 - prosody component port, used by videobridge. **Don't expose to the world in your firewall rules.**
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

Apache License, Version 2.0. See the [LICENSE](https://github.com/matrix-org/docker-jitsi/blob/master/LICENSE) file for more details.

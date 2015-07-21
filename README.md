# Saltmaster

Docker image inheritance:
 * shift/ubuntu:15.04
 * ubuntu:15.04

## Volumes

 * /srv/salt
 * /srv/pillar
 * /etc/salt
 * /srv/reactor

## Ports

 * 4505/tcp - ZeroMQ
 * 4506/tcp - ZeroMQ
 * 4510/udp - RAET

## Example usage

```
docker run -d \
  --name salt-master \
  -v /srv/saltmaster/etc:/etc/salt \
  -v /srv/saltmaster/pillar:/srv/pillar \
  -v /srv/saltmaster/salt:/srv/salt \
  shift/saltmaster
```

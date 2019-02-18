# dns-cache

[![Size and Layers](https://images.microbadger.com/badges/image/stixes/dns-cache.svg)](https://hub.docker.com/r/stixes/dns-cache)
[![Docker Pulls](https://img.shields.io/docker/pulls/stixes/dns-cache.svg)](https://hub.docker.com/r/stixes/dns-cache/)
[![Docker stars](https://img.shields.io/docker/stars/stixes/dns-cache.svg)](https://hub.docker.com/r/stixes/dns-cache)

Caching/Accelerating/Adblocking DNS server for small lan/home usage.

## Introduction

This image is a very small footprint (Alpine based) dnsmasqd setup, with a caching and accelerating DNS service. It bypasses your regular isp dns in favor of opendns and 1.1.1.1 dns services and sets op parallel queries for acceleration.

For caching it implements a rapid 3 sec. minimum TTL, and caches the 1024 most recently used domains, along with caching of failed lookups, which makes common lookups VERY fast!

Lastly it will on startup fetch an AdBlocking hostname list and ensures that you dont make queries to adserving domains. List is based on [https://pgl.yoyo.org/adservers/](https://pgl.yoyo.org/adservers/) and dnsmasqd supports no-resolv replies avoid invalid ips and avoiding requests to the servers all together.

You should start this image on you home lan server or NAS, and configure your DHCP to roll out this new ip for dns and reap the benefits of faster browsing and living on the internet.

## Configuration

Upon first startup after creation, the list of adblocked domains will be downloaded, but will be resued upon restarts.

You can set a custom url for downloading the Adblock configuration, and you can volumemap dnsmasqd configuration files into `/etc/dnsmasq.d/` to add or change to the configuration. You may infact wish to på this folder in a volume to avoid redownloading the blocklist on recreating the container.

## Running

You may simply run the container for testing with:

    docker run -d -p 53:53 -p 53:53/udp stixes/dns-cache

and test lookup using `nslookup`on the server being used.

As a `docker-compose` service (This would likely work in docker swarm mode aswell). Adding cpu_shares helps reduce latency further:

    services:
      dns:
        image: stixes/dns-cache
        restart: always
        ports:
          - "53:53"
          - "53:53/udp"
        cpu_shares: 8192

## Disclaimer

This image is used personally on my networks, however I cannot guarentee how it fairs on your network. Basicly, your milage may vary. 

Also, this image uses parallel queries of dns servers, which is generally percieved as bad practice, however the results speak for itself.

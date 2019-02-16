# dns-cache

Caching/Accelerating/Adblocking DNS server for small lan/home usage.

## Introduction

This image is a very small footprint (Alpine based) dnsmasqd setup, with a caching and accelerating DNS service. It bypasses your regular isp dns in favor of opendns and 1.1.1.1 dns services and sets op parallel queries for acceleration.

For caching it implements a rapid 3 sec. minimum TTL, and caches the 1024 most recently used domains, along with caching of failed lookups, which makes common lookups VERY fast!

Lastly it will on startup fetch an AdBlocking hostname list and ensures that you dont make queries to adserving domains. List is based on [https://pgl.yoyo.org/adservers/](https://pgl.yoyo.org/adservers/) and dnsmasqd supports no-resolv replies avoid invalid ips and avoiding requests to the servers all together.

## Running

As a `docker-compose` service (This would likely work in docker swarm mode aswell). Adding cpu_shares helps reduce latency further:

    services:
      dns:
        image: stixes/dns-cache
        restart: always
        ports:
          - "53:53"
          - "53:53/udp"
        cpu_shares: 8192


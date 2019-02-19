# dns-cache

[![Size and Layers](https://images.microbadger.com/badges/image/stixes/dns-cache.svg)](https://hub.docker.com/r/stixes/dns-cache)
[![Docker Pulls](https://img.shields.io/docker/pulls/stixes/dns-cache.svg)](https://hub.docker.com/r/stixes/dns-cache/)
[![Docker stars](https://img.shields.io/docker/stars/stixes/dns-cache.svg)](https://hub.docker.com/r/stixes/dns-cache)

Caching/Accelerating/Adblocking DNS server for small lan/home usage.

## Introduction

_So adblocking on a domain level, how does that help me?_ There is good evidence from research showing that [ad code slows down browsers](https://www.bbc.com/news/technology-47252725), not to mention that few people actually appriciate them.

_Why not use [PiHole](https://pi-hole.net/), or something simiilar ?_ You could, I whole heartedly support that project, and many of their results are used by this image. My goal is a simpler no-nonsense, "set and forget" solution, with zero configuration or follow-up needed.

_But my internet is fast, surely so is my DNS?_ Plenty of sources suggest using a different DNS to alieviate net speed problems ([example](https://www.idownloadblog.com/2016/04/29/increase-internet-speed-change-router-dns-settings/)). This is due to DNS having to complete _before_ any actual connection can be made, so you may argue that in these days of Megbit and Gigabit connections, DNS is _the_ most important bottleneck in your internet connection.

_But I use 1.1.1.1 as my dns, and it is very fast._ I for the most part, in a best case scenario performance will be equal to what you're experiencing, however in worst case scenarios using parrallel lookup help keep consistent performance, [even in worst case scenarios](https://ma.ttwagner.com/make-dns-fly-with-dnsmasq-all-servers/). Combine this with caching of common dns requests, which further reduces best case scenarios you will get a net-better experience. Lacking sources, my own setup shows a cache hitrate of about 50% on my home network.

This image is a very small footprint (Alpine based) dnsmasqd setup, with a caching and accelerating DNS service. It bypasses your regular isp dns in favor of opendns and 1.1.1.1 dns services and sets op parallel queries for acceleration.

For caching it implements a rapid 3 sec. minimum TTL, and caches the 1024 most recently used domains, along with caching of failed lookups, which makes common lookups VERY fast!

Lastly it will on startup fetch an AdBlocking hostname list and ensures that you dont make queries to adserving domains. The list is pulled from [StevenBlack's hosts files](https://github.com/StevenBlack/hosts) and dnsmasqd uses the hosts file to return NULL (0.0.0.0) replies to clients. This is shown to have the most reliable blocking rate, and avoids requests to any  servers all together. You can configure the `BLOCKLIST_URL` to point at any list in hosts format, such as any of the other lists provided in the link mentioned.

You should start this image on you home lan server or NAS, and configure your Router's DHCP to roll out this new ip for dns and reap the benefits of faster browsing and living on the internet.

## Configuration

Upon first startup after creation, the list of adblocked domains will be downloaded and placed in `/etc/hosts.dnsmasq`, but will be resued upon restarts.

You can set a custom url for downloading the blocking hosts in the `BLOCKLIST_URL` environment variable.
If you wish to add additional configuration to dnsmasq, you can volume mount `/etc/dnsmasq.d/`. 

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

FROM alpine:latest
MAINTAINER jesper.mathiassen@gmail.com

ENV BLOCKLIST_URL=https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling/hosts
EXPOSE 53 53/udp 

COPY run.sh dnsmasq.conf /etc/
RUN apk --no-cache add curl dnsmasq && \
    mkdir /etc/dnsmasq.hosts.d

CMD /etc/run.sh

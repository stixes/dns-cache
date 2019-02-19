FROM alpine:3.9
MAINTAINER jesper.mathiassen@gmail.com

ENV BLOCKLIST_URL=https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling/hosts
EXPOSE 53 53/udp 

RUN apk --no-cache add curl dnsmasq
COPY run.sh dnsmasq.conf /etc/

CMD /etc/run.sh

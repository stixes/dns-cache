FROM alpine:3.9
MAINTAINER jesper.mathiassen@gmail.com

ENV BLOCKLIST_URL=https://pgl.yoyo.org/as/serverlist.php?hostformat=dnsmasq-server&showintro=0&mimetype=plaintext
EXPOSE 53 53/udp 

RUN apk --no-cache add curl dnsmasq
COPY run.sh dnsmasq.conf /etc/

CMD /etc/run.sh

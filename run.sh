#!/bin/sh

if [ ! -f /etc/dnsmasq.hosts.d/stevenblack.hosts ]; then
  echo "Downloading updated blocklist from StevenBlack.."
  echo " - List url: ${BLOCKLIST_URL}"
  curl -sSLf ${BLOCKLIST_URL} -o /etc/dnsmasq.hosts.d/stevenblack.hosts
  echo " - Entries: $(wc -l /etc/dnsmasq.hosts.d/stevenblack.hosts)"
  echo "Done."
else
  echo "Reusing previously downloaded blocklist."
fi

echo "Starting DNS services"
dnsmasq -k --all-server --log-facility=-

#!/bin/sh

if [ ! -f /etc/dnsmasq.d/adblock.conf ]; then
  echo "Downloading updated blocklist.."
  echo " - List url: ${BLOCKLIST_URL}"
  curl -sSLf ${BLOCKLIST_URL} -o /etc/dnsmasq.d/adblock.conf
  echo " - Entries: $(wc -l /etc/dnsmasq.d/adblock.conf)"
  echo "Done."
else
  echo "Reusing previously downloaded blocklist."
fi

echo "Starting DNS services"
dnsmasq -k --all-server --log-facility=-

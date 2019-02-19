#!/bin/sh

if [ ! -f /etc/hosts.dnsmasq ]; then
  echo "Downloading updated blocklist.."
  echo " - List url: ${BLOCKLIST_URL}"
  curl -sSLf ${BLOCKLIST_URL} -o /etc/hosts.dnsmasq
  echo " - Entries: $(wc -l /etc/hosts.dnsmasq)"
  echo "Done."
else
  echo "Reusing previously downloaded blocklist."
fi

echo "Starting DNS services"
dnsmasq -k --all-server --log-facility=-

#!/bin/sh

# Start cloudflared with the specified options in the background
/usr/local/bin/cloudflared proxy-dns --port 5053 --upstream https://cloudflare-dns.com/dns-query &
FROM pihole/pihole:latest

EXPOSE 5053

COPY start-cloudflared.sh /usr/local/bin/start-cloudflared.sh

RUN apt-get update \
    && apt-get install -y wget \
    && wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64 \
    && mv -f ./cloudflared-linux-arm64 /usr/local/bin/cloudflared \
    && useradd -s /usr/sbin/nologin -r -M cloudflared \
    && chown cloudflared:cloudflared /etc/default/cloudflared \
    && chown cloudflared:cloudflared /usr/local/bin/cloudflared\
    && chmod +x /usr/local/bin/cloudflared \
    && chmod +x /usr/local/bin/start-cloudflared.sh

CMD ["/usr/local/bin/start-cloudflared.sh"]
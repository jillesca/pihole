FROM pihole/pihole:latest

EXPOSE 5053

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY start-cloudflared.sh /usr/local/bin/start-cloudflared.sh
COPY update-cloudflared.sh /usr/local/bin/update-cloudflared.sh

RUN apt-get update \
    && apt-get install -y wget cron \
    && wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64 \
    && mv -f ./cloudflared-linux-arm64 /usr/local/bin/cloudflared \
    && useradd -s /usr/sbin/nologin -r -M cloudflared \
    && chown cloudflared:cloudflared /usr/local/bin/cloudflared \
    && chmod +x /usr/local/bin/cloudflared \
    && chmod +x /usr/local/bin/start-cloudflared.sh \
    && chmod +x /usr/local/bin/update-cloudflared.sh \
    && mkdir -p /etc/crontabs \
    && touch /etc/crontabs/root \
    && echo "*/2 * * * * /usr/local/bin/update-cloudflared.sh" >> /etc/crontabs/root

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
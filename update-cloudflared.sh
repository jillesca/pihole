#!/bin/sh

LOG_FILE="/var/log/cloudflared-update.log"

# Log the start of the update command
echo "$(date): Running cloudflared update command" >> $LOG_FILE

# Run the cloudflared update command
/usr/local/bin/cloudflared update

# Check if the update command exited with code 11 (indicating an update happened)
if [ $? -eq 11 ]; then
    # Log that an update was available and successful
    echo "$(date): Update available and successful. Restarting cloudflared service." >> $LOG_FILE
    # Restart the cloudflared service
    /usr/local/bin/start-cloudflared.sh
else
    # Log that no update was available
    echo "$(date): No update available." >> $LOG_FILE
fi
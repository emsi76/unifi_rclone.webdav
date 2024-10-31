#!/bin/bash

# Load environment variables
set -a
source /data/rclone/rclone_webdav.env
set +a

tail -f ${RCLONE_WEBDAV_LOG_PATH} | grep --line-buffered ".*Unauthorized request.*from\s[$(grep -o '^[aA-zZ]*[^:]' /data/rclone/htpasswd | paste -s -d '|')]" | grep --line-buffered -o '\S*$' | while read line;
    do
        if grep -c "^$(date +'%Y/%m/%d')\s$(date +'%H').*Unauthorized request.*from\swebdav" ${RCLONE_WEBDAV_LOG_PATH} > ${RCLONE_WEBDAV_FAILED_LIMIT}
        then 
            sed -i "s/^$line/#$line/g" /data/rclone/htpasswd
            echo "banned $line at $(date +'%Y/%m/%d %H:%M:%S')" >> /data/rclone/banned_users.txt
    fi
done

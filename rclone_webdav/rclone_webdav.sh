#!/bin/bash

# Load environment variables
set -a
source /data/rclone/rclone_webdav.env
set +a

rclone -v serve webdav "${RCLONE_WEBDAV_ROOT_PATH}" --addr :${RCLONE_WEBDAV_PORT} --key /data/unifi-core/config/unifi-core.key --cert /data/unifi-core/config/unifi-core.crt --htpasswd /data/rclone/htpasswd --log-file=${RCLONE_WEBDAV_LOG_PATH}

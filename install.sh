#!/bin/bash

set -e
SCRIPT_DIR=$(dirname ${0})

export repoUrl = 'https://github.com/emsi76/unifi_rclone.webdav/blob/main'
export SERVICE_NAME='rclone_webdav'

# Get the firmware version
export FIRMWARE_VER=$(ubnt-device-info firmware || true)
# Get the Harware Model
export MODEL="$(ubnt-device-info model || true)"

export RCLONE_WEBDAV_FOLDER='/data/rclone'

# Check os version

check_version_model_dir(){
	if [ $(echo ${FIRMWARE_VER} | sed 's#\..*$##g') -gt 1 ]
		then
        	export DATA_DIR="/data"
	else
		echo "- Unsupported firmware - ${FIRMWARE_VER}"
		exit 1
	fi

	case "${MODEL}" in
	"UniFi Dream Machine Pro"|"UniFi Dream Machine"|"UniFi Dream Router"|"UniFi Dream Machine SE")
		echo "${MODEL} running firmware ${FIRMWARE_VER} detected, installing ubios-cert in ${DATA_DIR}..."
		;;
		*)
		echo "- Unsupported model - ${MODEL}"
		exit 1
		;;
	esac
	if [ ! -d "$DATA_DIR" ]; then
  		echo "- Required '$DATA_DIR' directory does not exist -"
		exit 1
	fi
	echo
}

# Check if service exists
service_exists() {
    local n=$1
    if [[ $(systemctl list-units --all -t service --full --no-legend "$n.service" | sed 's/^\s*//g' | cut -f1 -d' ') == $n.service ]]; then
        return 0
    else
        return 1
    fi
}

# Download files
get_rclone_webdav(){
	mkdir -p $RCLONE_WEBDAV_FOLDER
	wget -q -O "$RCLONE_WEBDAV_FOLDER/rclone_webdav.sh" "$repoUrl/rclone_webdav/rclone_webdav.sh"
	wget -q -O "$RCLONE_WEBDAV_FOLDER/rclone_webdav.service" "$repoUrl/rclone_webdav/rclone_webdav.service"
	wget -nc -q -O "$RCLONE_WEBDAV_FOLDER/rclone_webdav.env" "$repoUrl/rclone_webdav/rclone_webdav.env"
	wget -nc -q -O "$RCLONE_WEBDAV_FOLDER/htpasswd" "$repoUrl/rclone_webdav/htpasswd"
	chmod oug+rx $repoUrl/rclone_webdav/rclone_webdav.sh
	chmod oug+rx $repoUrl/rclone_webdav/rclone_webdav.service
}

install_service(){
	cp $RCLONE_WEBDAV_FOLDER/rclone_webdav.service  /etc/systemd/system/rclone_webdav.service
	sudo systemctl daemon-reload
	sudo systemctl start rclone_webdav.service
	sudo systemctl enable rclone_webdav.service
}

update_service(){
	sudo systemctl stop rclone_webdav.service
	sudo systemctl disable rclone_webdav.service
	cp $RCLONE_WEBDAV_FOLDER/rclone_webdav.service  /etc/systemd/system/rclone_webdav.service
	sudo systemctl daemon-reload
	sudo systemctl start rclone_webdav.service
	sudo systemctl enable rclone_webdav.service
}

#install rclone
install_rclone(){
	sudo -v ; curl https://rclone.org/install.sh | sudo bash
}


check_version_model_dir
get_rclone_webdav
install_rclone

if service_exists rclone_webdav; 
	then
		update_service
		echo serive updated
    	else
		install_service
		echo service installed
fi


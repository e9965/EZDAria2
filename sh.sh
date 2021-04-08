#!/bin/bash
export DOWNFILE=${3}
rm -rf ${DOWNFILE}.aria2
RCLONE=/datasets/rclone.conf
OLD_IFS=$IFS
IFS=$(echo -ne "\n\b")
#-----------------------------------------------------------------------
#<程序運行-转移压缩包>
rclone move ${DOWNFILE} Onedrive:/ -P -q --transfers=1 --ignore-errors --no-traverse --create-empty-src-dirs --delete-empty-src-dirs --config "${RCLONE}"
IFS=$OLD_IFS
exit 0

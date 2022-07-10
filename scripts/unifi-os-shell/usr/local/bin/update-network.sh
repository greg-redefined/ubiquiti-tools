#!/bin/bash

FIRMWARE_URL=${1:-}
FIRMWARE_PATH=/tmp/unifi_sysvinit_all.deb

if [[ -z $FIRMWARE_URL ]]; then
  echo "FIRMWARE_URL must be specified"
  exit 1
fi

echo "Removing old firmware"
rm -f ${FIRMWARE_PATH} || exit 1

echo "Downloading new firmware"
curl -o ${FIRMWARE_PATH} ${FIRMWARE_URL} || exit 1

echo "Installing new firmware"
DEBIAN_FRONTEND=noninteractive \
  dpkg -i ${FIRMWARE_PATH} || exit 1

echo "Cleaning up download"
rm -f ${FIRMWARE_PATH} || exit 1

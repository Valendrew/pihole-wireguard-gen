#!/bin/bash -e

if [ -n "${SSH_PORT}" ]; then
  sed -i "s/#Port 22/Port ${SSH_PORT}/" "${ROOTFS_DIR}/etc/ssh/sshd_config"
else
  echo "SSH port is not set"
fi

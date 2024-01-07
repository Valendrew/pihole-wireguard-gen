#!/bin/bash -e

DOCKER_GPG_URL="https://download.docker.com/linux/debian/gpg"

curl -fsSL "$DOCKER_GPG_URL" | gpg --dearmor -o "files/docker.gpg" --yes

file "files/docker.gpg"

KEYRINGS_FOLDER="${ROOTFS_DIR}/etc/apt/keyrings"
install -v -m 0755 -d "${KEYRINGS_FOLDER}"
install -v -m 0644 "files/docker.gpg" "${KEYRINGS_FOLDER}/"

echo "deb [arch=arm64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian ${RELEASE} stable" > "${ROOTFS_DIR}/etc/apt/sources.list.d/docker.list"

on_chroot << EOF
apt-get update
EOF

on_chroot <<EOF
groupadd -f docker
usermod -aG docker $FIRST_USER_NAME
EOF

DOCKER_FOLDER="${ROOTFS_DIR}/home/${FIRST_USER_NAME}/projects/docker"
install -v -m 0755 -o 1000 -g 1000 -d "${DOCKER_FOLDER}"
install -v -m 0644 -o 1000 -g 1000 "files/docker-compose.yml" "${DOCKER_FOLDER}/"
install -v -m 0644 -o 1000 -g 1000 "files/update-containers.sh" "${DOCKER_FOLDER}/"
install -v -m 0644 -o 1000 -g 1000 "files/.env" "${DOCKER_FOLDER}/"


APPDATA_FOLDER="/docker/appdata"
install -v -m 0755 -o 1000 -g 1000 -d "${ROOTFS_DIR}${APPDATA_FOLDER}"

on_chroot <<EOF
chown -R $FIRST_USER_NAME:$FIRST_USER_NAME $(dirname $DOCKER_FOLDER)
chown -R $FIRST_USER_NAME:$FIRST_USER_NAME $(dirname $APPDATA_FOLDER)
chmod -R a=,a+rX,u+w,g+w $(dirname $APPDATA_FOLDER)
EOF

HOMEPAGE_FOLDER="${ROOTFS_DIR}${APPDATA_FOLDER}/homepage_config"
install -v -m 0755 -d $HOMEPAGE_FOLDER
install -v -m 0664 "files/bookmarks.yaml" "${HOMEPAGE_FOLDER}/"
install -v -m 0664 "files/docker.yaml" "${HOMEPAGE_FOLDER}/"
install -v -m 0664 "files/services.yaml" "${HOMEPAGE_FOLDER}/"
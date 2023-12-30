#!/bin/bash -e
cd pi-gen

# SKIP_IMAGES for the stage2
echo "Skip image at stage2"
if [ -f "./stage2/SKIP_IMAGES" ]; then
    rm stage2/SKIP_IMAGES
fi

touch stage2/SKIP_IMAGES

echo "Build image"
CONFIG_FILE="../config"
source $CONFIG_FILE
sudo SSH_PORT=$SSH_PORT ./build.sh -c $CONFIG_FILE
rm stage2/SKIP_IMAGES

echo "Successfully created the image"
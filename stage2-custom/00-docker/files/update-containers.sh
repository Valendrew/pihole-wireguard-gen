#!/bin/sh

echo "Updating docker containers"
docker compose down
docker compose pull
docker compose up -d
docker image prune -a -f --filter "until=24h"

# Pi-hole + Wireguard with pi-gen

## Clone

```bash
git clone --recurse-submodules URL
```

## Pre setup

- Create a `.env` file at `stage2-custom/00-docker/files`, with a structure as follows:

| Variable           | Description                                     |
| ------------------ | ----------------------------------------------- |
| DEVICE_IP          | IP address of the device                        |
| WIREGUARD_HOST     | The public hostname of the VPN server[[1]](#1)  |
| WIREGUARD_PASSWORD | Password for the WireGuard Web UI[[1]](#1)      |
| WIREGUARD_PORT     | The host public UDP port for WireGuard[[1]](#1) |
| PIHOLE_PASSWORD    | Password for Pi-hole Web UI[[2]](#2)            |
| PIHOLE_PORT        | Port for Pi-hole Web UI[[2]](#2)                |
| PIHOLE_API_KEY     | API key for Pi-hole[[2]](#2)                    |
| HOMEPAGE_PORT      | Port for the homepage WEB UI[[3]](#3)           |

<a id="1">[1]</a>: [Wireguard options](https://github.com/wg-easy/wg-easy?tab=readme-ov-file#options).

<a id="2">[2]</a> : [Pi-hole options](https://github.com/pi-hole/docker-pi-hole?tab=readme-ov-file#environment-variables).

<a id="3">[3]</a> : [Homepage options](https://gethomepage.dev/latest/installation/docker/).

- The variable `PIHOLE_API_KEY` is set only after containers have been created, by generating the key at `Pi-hole WEB UI -> Settings -> API -> Show API token`.

## Create image

```bash
cd pi-gen
sudo ./build.sh
```

## Post setup

- Router configuration
  - Set device IP to `DEVICE_IP` as static
  - Port forward the `DEVICE_IP` in your router to access Wireguard for an external network.
- RaspberryPi configuration
  - Keyboard configuration
  - User and password

## Launch Docker

```bash
cd ~/project/docker
docker compose up -d
```
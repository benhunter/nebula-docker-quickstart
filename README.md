# Nebula Docker Quickstart

A Nebula overlay network in Docker Compose. Configures a Lighthouse and two server endpoints. Demonstrates nginx and ssh accessible only from inside the overlay network.

Tested on Mac.

# Setup

```sh
./setup-mac.sh
docker compose up -d --build
```

# SSH

```sh
docker compose exec netshoot2 ssh root@192.168.100.11
```

Won't work outside overlay:
```sh
docker compose exec netshoot2 ssh root@192.168.42.11
```

# Nginx

```sh
docker compose exec netshoot2 http 192.168.100.11
```

Won't work outside overlay:
```sh
docker compose exec netshoot2 http 192.168.42.11
```

# ICMP

```sh
docker compose exec server1 ping 192.168.100.1 -c 2
docker compose exec server1 ping 192.168.42.42 -c 2
docker compose exec server1 ping 192.168.100.12 -c 2
docker compose exec server1 ping 192.168.42.12 -c 2
docker compose exec lighthouse ping 192.168.100.11 -c 2
docker compose exec lighthouse ping 192.168.42.11 -c 2
docker compose exec lighthouse ping 192.168.100.12 -c 2
docker compose exec lighthouse ping 192.168.42.12 -c 2
docker compose exec server2 ping 192.168.100.1 -c 2
docker compose exec server2 ping 192.168.42.42 -c 2
docker compose exec server2 ping 192.168.100.11 -c 2
docker compose exec server2 ping 192.168.42.11 -c 2
```
# Iterate

```sh
docker compose down && docker compose up -d --build
```

Run single container with normal nebula entrypoint
```sh
docker run --rm -v ./lighthouse/config.yaml:/config/config.yaml -v ./lighthouse/pki:/etc/nebula --cap-add=NET_ADMIN --device /dev/net/tun nebula-alpine
```

Run and attach to shell
```sh
docker run -it --rm -v ./lighthouse/config.yaml:/config/config.yaml -v ./lighthouse/pki:/etc/nebula --cap-add=NET_ADMIN --device /dev/net/tun --entrypoint sh nebula-alpine
```


Direct ssh (would reqire a host port mapping)
```sh
ssh -i ubuntu-ssh/ssh_keys/id_rsa -p 2222 root@localhost
```
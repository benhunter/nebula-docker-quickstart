# nebula-docker-quickstart

# Setup

```sh
./generate-ssh-keys.sh
docker compose up -d --build
```

```sh
./nebula-cert sign -name "lighthouse" -ip "192.168.100.1/24"
./nebula-cert sign -name "server1" -ip "192.168.100.11/24" -groups "servers"
./nebula-cert sign -name "server2" -ip "192.168.100.12/24" -groups "servers"
```

# SSH

```sh
ssh -i ubuntu-ssh/ssh_keys/id_rsa -p 2222 root@localhost
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

See connection
```sh
docker compose exec server1 ping 192.168.100.1
docker compose exec lighthouse ping 192.168.100.11
```
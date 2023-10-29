# nebula-docker-quickstart

# Setup

```sh
./generate-ssh-keys.sh
docker compose up -d --build
```

# SSH

```sh
ssh -i ubuntu-ssh/ssh_keys/id_rsa -p 2222 root@localhost
```

# Iterate

```sh
docker compose down && docker compose up -d --build
```
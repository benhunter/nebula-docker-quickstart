#!/bin/sh

# ICMP
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

# SSH
docker compose exec netshoot2 ssh root@192.168.100.11 -- ip a

# HTTP
docker compose exec netshoot2 http --print=h 192.168.100.11

# Expected to fail
docker compose exec netshoot2 ssh root@192.168.42.11
docker compose exec netshoot2 http 192.168.42.11

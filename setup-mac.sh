#!/bin/sh

# Install Nebula
if ! command -v nebula &> /dev/null; then
  brew install nebula
fi

# Create Certificate Authority
nebula-cert ca -name "Nebula Hackerspace" -out-crt ca/ca.crt -out-key ca/ca.key
cp ca/ca.crt lighthouse/pki/ca.crt
cp ca/ca.crt server1/pki/ca.crt
cp ca/ca.crt server2/pki/ca.crt

# Generate host certificates
nebula-cert sign -name "lighthouse" -ip "192.168.100.1/24" -ca-crt ca/ca.crt -ca-key ca/ca.key -out-crt lighthouse/pki/lighthouse.crt -out-key lighthouse/pki/lighthouse.key
nebula-cert sign -name "server1" -ip "192.168.100.11/24" -ca-crt ca/ca.crt -ca-key ca/ca.key -groups "servers" -out-crt server1/pki/server1.crt -out-key server1/pki/server1.key
nebula-cert sign -name "server2" -ip "192.168.100.12/24" -ca-crt ca/ca.crt -ca-key ca/ca.key -groups "servers" -out-crt server2/pki/server2.crt -out-key server2/pki/server2.key

./generate-ssh-keys.sh

#!/bin/sh

mkdir ubuntu-ssh/ssh_keys

# Generate ssh keys with an empty passphrase.
ssh-keygen -f ubuntu-ssh/ssh_keys/id_rsa -N ""

# authorized_keys is used by the ssh server to authenticate clients.
cp ubuntu-ssh/ssh_keys/id_rsa.pub ubuntu-ssh/ssh_keys/authorized_keys
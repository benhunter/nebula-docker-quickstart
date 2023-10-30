# Use the official Ubuntu base image
FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-server iproute2

# Create the SSH directory and generate keys
RUN mkdir /var/run/sshd
# RUN ssh-keygen -A

# Add your custom SSH config (if you have one)
# COPY ./sshd_config /etc/ssh/sshd_config

# Add authorized keys for root login
# COPY ./ssh_keys/id_rsa.pub /root/.ssh/authorized_keys
# RUN chmod 600 /root/.ssh/authorized_keys && chmod 700 /root/.ssh

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

# To generate keys outside the image, run this first:
#
# mkdir ssh_keys
# ssh-keygen -f ssh_keys/id_rsa

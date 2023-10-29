# Use the official Ubuntu base image
FROM ubuntu:latest

# Install OpenSSH Server
RUN apt-get update && apt-get install -y openssh-server iproute2

# Create the SSH directory and generate keys
RUN mkdir /var/run/sshd
# RUN ssh-keygen -A

# Add your custom SSH config (if you have one)
# COPY ./sshd_config /etc/ssh/sshd_config

# Add authorized keys for root login
# COPY ./ssh_keys/id_rsa.pub /root/.ssh/authorized_keys
# RUN chmod 600 /root/.ssh/authorized_keys && chmod 700 /root/.ssh

# Expose the SSH port
EXPOSE 22

# Start the SSH server
CMD ["/usr/sbin/sshd", "-D"]

# Alternative Dockerfile
#
# Run this first:
# mkdir ssh_keys
# ssh-keygen -f ssh_keys/id_rsa
#
# FROM ubuntu:latest
# RUN apt-get update && apt-get install -y openssh-server
# RUN mkdir /var/run/sshd
# COPY ./ssh_keys/id_rsa.pub /root/.ssh/authorized_keys
# RUN chmod 600 /root/.ssh/authorized_keys
# RUN chmod 700 /root/.ssh
# CMD ["/usr/sbin/sshd", "-D"]
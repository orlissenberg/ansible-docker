#!/bin/sh

CID=$(sudo docker run -d -i orlissenberg/ansible-sshd-wheezy);
IPADDRESS=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CID});

# Create a hosts file.
echo "[webservers]" > hosts

# Install on localhost.
#echo "localhost ansible_connection=local" >> hosts

# Requires sshpass.
sudo apt-get install -y sshpass
echo "${IPADDRESS} ansible_connection=ssh ansible_ssh_user=root ansible_ssh_pass=root" >> hosts

# Need this because I'm running on Windows ...
cp hosts /tmp/hosts
chmod 0644 /tmp/hosts

# Create an ansible configuration file in the local directory.
echo "[defaults]\nroles_path = ../" > ansible.cfg
echo "host_key_checking = False" >> ansible.cfg

# Should show changes.
ansible-playbook playbook.yml -i /tmp/hosts

# Check if idempotent.
ansible-playbook playbook.yml -i /tmp/hosts

# Clean up.
rm hosts
rm /tmp/hosts
rm ansible.cfg

# Might need these commands for science!
echo "sudo docker kill ${CID}"
echo "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@$IPADDRESS"

# No longer need the container.
sudo docker kill ${CID}
sudo docker rm ${CID}

# References:
# http://stackoverflow.com/questions/17157721/getting-a-docker-containers-ip-address-from-the-host
# https://servercheck.in/blog/testing-ansible-roles-travis-ci-github
# https://docs.docker.com/articles/using_supervisord/
# https://docs.ansible.com/playbooks_error_handling.html



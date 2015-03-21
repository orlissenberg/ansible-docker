#!/bin/sh

CID=$(sudo docker run -d -i orlissenberg/docker-sshd-wheezy);
#CID=$(sudo docker run -d -i orlissenberg/docker-sshd-centos6);
IPADDRESS=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CID});

# Create a hosts file.
printf "[webservers]\n" > hosts

# Install on localhost.
#echo "localhost ansible_connection=local" >> hosts

# Requires sshpass.
# sudo apt-get install -y sshpass
# sudo yum install -y sshpass
printf "${IPADDRESS} ansible_connection=ssh ansible_ssh_user=root ansible_ssh_pass=root\n" >> hosts

# Need this because I'm running on Windows ...
cp hosts /tmp/hosts
chmod 0644 /tmp/hosts

# Create an ansible configuration file in the local directory.
printf "[defaults]\nroles_path = ../\n" > ansible.cfg
printf "host_key_checking = False\n" >> ansible.cfg

# Should show changes.
ansible-playbook playbook.yml -i /tmp/hosts --extra-vars="docker_test=true"

# Check if idempotent.
ansible-playbook playbook.yml -i /tmp/hosts --extra-vars="docker_test=true"

# Clean up.
rm hosts; rm /tmp/hosts; rm ansible.cfg

# Might need these commands for science!
printf "sudo docker kill ${CID}\n"
printf "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@$IPADDRESS\n"

# No longer need the container.
sudo docker kill ${CID}
sudo docker rm ${CID}

# References:
# http://stackoverflow.com/questions/17157721/getting-a-docker-containers-ip-address-from-the-host
# https://servercheck.in/blog/testing-ansible-roles-travis-ci-github
# https://docs.docker.com/articles/using_supervisord/
# https://docs.ansible.com/playbooks_error_handling.html

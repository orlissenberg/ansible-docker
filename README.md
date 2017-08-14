#Ansible Docker Role

##Tested Linux Distributions

See also the test.sh which tests this role by using Docker!

  - Debian 8

Note that "--iptables=false" has been set in the configuration! See [this](https://fralef.me/docker-and-iptables.html).

##Dependencies

None.

##Example Playbook

    ---
    - hosts: webservers
      gather_facts: yes
      become: yes

      roles:
        - docker

##Notes

[Installing Docker on Debian Jessie](http://www.boronine.com/2013/12/30/Installing-Docker-on-Debian-Jessie/)

[Fix Docker's networking DNS config](https://robinwinslow.uk/2016/06/23/fix-docker-networking-dns/)

[How to Enable IP Forwarding in Linux](http://www.ducea.com/2006/08/01/how-to-enable-ip-forwarding-in-linux/)

Show current DNS:

    nmcli dev show | grep DNS

##License

MIT

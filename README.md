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

[http://www.boronine.com/2013/12/30/Installing-Docker-on-Debian-Jessie/](Installing Docker on Debian Jessie)

##License

MIT

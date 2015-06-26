#Ansible Docker Role

##Tested Linux Distributions

See also the test.sh which tests this role by using Docker!

  - Debian 7
  - CentOS 6

##Dependencies

None.

##Example Playbook

    ---
    - hosts: webservers
      gather_facts: yes
      sudo: yes

      roles:
        - docker

##Notes

[http://www.boronine.com/2013/12/30/Installing-Docker-on-Debian-Jessie/](Installing Docker on Debian Jessie)

##License

MIT

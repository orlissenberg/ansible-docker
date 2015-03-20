#Ansible Docker Role

##Requirements

  - Debian 7

##Dependencies

None.

##Example Playbook

    ---
    - hosts: webservers
      gather_facts: yes
      sudo: yes
      
      roles:
        - docker

##License

MIT


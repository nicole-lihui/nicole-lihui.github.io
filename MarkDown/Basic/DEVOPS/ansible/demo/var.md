```bash
        
    #   when: ansible_default_ipv4.address != "{{ hostvars[groups['manager'][0]]['ansible_default_ipv4']['address'] }}"

    # - debug: var=hostvars[inventory_hostname]['ansible_default_ipv4']['address']
    # - debug: var=hostvars[groups['manager'][0]]['ansible_default_ipv4']['address'] 
    # - debug: msg={{ groups.all}}
    # - debug: msg={{ group_names }}
    #   when: group_names == ["manager"]
    # - debug: msg={{ play_hosts[0] }}
```

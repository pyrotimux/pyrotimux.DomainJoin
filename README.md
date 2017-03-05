DomainJoin
=========
[![Build Status](https://travis-ci.org/pyrotimux/pyrotimux.DomainJoin.png?branch=master)](https://travis-ci.org/pyrotimux/pyrotimux.DomainJoin)

Join windows domain.

Requirements
------------

WMF 5 (or powershell) on window box.

Role Variables
--------------
Please pass in the variable below. Example is shown below.
```
# rename the pc based on the ip before joining.
domain_dict: {"10.255.10.20":"KGAD", "10.255.10.21":"KGSTRGUTL", "10.255.10.22":"KGTS1", "10.255.10.23":"KGTS2"}

# domain info.
domainname: "pyro.testrealm.local"
ad_user: "pyro\\ichiban"
ad_pass: "ichiV@gran7"

# ifaces to be updated with domain ip.
iface:
  - { name: 'Ethernet', dns: '10.255.10.20' }
  - { name: 'Ethernet 2', dns: '10.255.10.20' }
```

Dependencies
------------

You need the library folder in your ansible directory. It has the dsc modules needed for the play to work.

If you need to init the domain first:
https://github.com/pyrotimux/domain_init

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:
```
- hosts: all
  gather_facts: true
  roles:
     - domain_join
```

License
-------

MIT

Author Information
------------------

chaosmuskey@gmail.com

#!/usr/bin/env bash
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i ~{{instance_user}}/openshift_inventory.cfg ~{{instance_user}}/openshift-ansible/playbooks/byo/config.yml

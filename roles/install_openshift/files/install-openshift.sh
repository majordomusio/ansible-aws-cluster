#!/usr/bin/env bash
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i ~{{deploy_user}}/openshift_inventory.cfg ~{{deploy_user}}/openshift-ansible/playbooks/byo/config.yml

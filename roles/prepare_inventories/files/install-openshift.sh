#!/usr/bin/env bash

INVENTORY=$1
if [ "$INVENTORY" == "" ]; then
  INVENTORY="single_master_inventory.cfg"
fi

export ANSIBLE_HOST_KEY_CHECKING=False
export INVENTORY

ansible-playbook -i ~{{instance_user}}/$INVENTORY ~{{instance_user}}/openshift-ansible/playbooks/byo/config.yml

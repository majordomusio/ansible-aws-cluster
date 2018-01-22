#!/usr/bin/env bash

#
# Run with:
#
# ./install-openshift.sh |& tee install-openshift.log
#
# 

export ANSIBLE_HOST_KEY_CHECKING=False

ansible-playbook -i ~{{instance_user}}/inventory.cfg ~{{instance_user}}/openshift-ansible/playbooks/byo/config.yml

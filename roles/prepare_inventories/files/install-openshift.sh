#!/usr/bin/env bash

#
# Run with:
#
# ./install-openshift.sh |& tee install-openshift.log
#
# 

export ANSIBLE_HOST_KEY_CHECKING=False

start_time=$(date +%s)

ansible-playbook -i ~{{instance_user}}/inventory.cfg ~{{instance_user}}/openshift-ansible/playbooks/byo/config.yml

end_time=$(date +%s)
dt=$(echo "$end_time - $start_time" | bc)
dm=$(echo "$dt/60" | bc)
ds=$(echo "$dt-60*$dm" | bc)

printf "\nTotal execution time of playbook: %02dm %02ds.\n\n" $dm $ds
# ansible-aws-cluster-openshift
Provisions a simple OpenShift cluster environment on AWS


```shell
ansible-playbook -i inventory/inventory_eu_west_1 playbooks/provision_bastion.yml
```


```shell
ansible-playbook -i inventory/inventory_eu_west_1 playbooks/provision.yml
```


## Cluster Topology

![Small Cluster](./docs/small-openshift.png)


![Medium Cluster](./docs/medium-openshift.png)


![HA Cluster](./docs/large-openshift.png)
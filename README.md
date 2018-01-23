# ansible-aws-cluster-openshift
Provisions a simple OpenShift cluster environment on AWS

This repository contains [Ansible](https://www.ansible.com/) roles and
playbooks to install, upgrade, and manage simple
[OpenShift](https://www.openshift.com/) clusters on AWS.

The following cluster types are supported:

* Single DEV - A OpenShift installation on a single EC2 instance.
* Small - 1 Master Node, 1 .. n App Nodes
* Medium - 1 Master Node, 1 Infra Node, 1 .. n App Nodes
* Large - 3 Master Nodes, 2 Infra Nodes, 1 Load Balancer, 4 .. n App Nodes

The playbooks will create all of the AWS infrastructure to support above cluster types as well as the OpenShift clsuter itself.

### Where do I start?

In order to provision a cluster, a couple of items have to be in place:

1) AWS account credentials must be present (aws_access_key, aws_secret_key)
2) Create a SSH key file (in the AWS console), and place the public key in e.g. `~/.ssh`.
3) Created a pre-built AMI. To speed in the provisioning of medium and large clusters, a pre-built AMI is used.


### Let's Provision!

Warning:  Running these plays will provision items in your AWS account, and you may incur billing charges. These plays are not suitable for the AWS free-tier.



# OLD


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
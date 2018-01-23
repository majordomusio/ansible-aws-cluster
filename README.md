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

The playbooks will create all of the AWS infrastructure to support above cluster types and install the OpenShift cluster itself.

### Where do I start?

In order to provision a cluster, a couple of items have to be in place:

1) AWS account credentials must be present (aws_access_key, aws_secret_key)
2) In order to route traffic to the cluster, you need a public zone file and doamin configured in `AWS Route53`.
3) Create a SSH key file (in the AWS console), and place the public key in e.g. `~/.ssh`.
4) Prepare your `inventory file` by making a copy of e.g. `inventory/inventory_small.example`.
5) Modify your inventory file to match your needs.
6) Created a pre-built AMI. To speed in the provisioning of medium and large clusters, a pre-built AMI is used.


### Let's Provision!

Warning:  Running these plays will provision items in your AWS account, and you may incur billing charges. These plays are not suitable for the AWS free-tier.

#### Step 1 - Prepare the Inventory

Make a copy of e.g. inventory/inventory_small.example

#### Step 2 - Create the AMI

```shell
ansible-playbook -i inventory/inventory_xyz playbooks/build_ami.yml
```

#### Step 3 - Create the Bastion host

```shell
ansible-playbook -i inventory/inventory_xyz playbooks/provision_bastion.yml
```

#### Step 4 - Create the infrastructure

```shell
ansible-playbook -i inventory/inventory_xyz playbooks/provision.yml
```

#### Step 5 - Create the cluster

```shell
ssh <bastion>
./install_openshift.sh
```

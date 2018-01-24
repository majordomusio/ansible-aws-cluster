# ansible-aws-cluster-openshift

This repository contains [Ansible](https://www.ansible.com/) roles and
playbooks to install, upgrade, and manage simple
[OpenShift](https://www.openshift.com/) clusters on AWS.

The following cluster types are supported:

* Small - 1 Master Node, 1 .. n App Nodes
* Medium - 1 Master Node, 1 Infra Node, 1 .. n App Nodes
* Large - 3 Master Nodes, 2 Infra Nodes, 1 Load Balancer, 4 .. n App Nodes
* Single Developer - A OpenShift installation on a single EC2 instance. (COMING SOON).

The playbooks will create the AWS infrastructure to support above cluster types before installing OpenShift itself.

### Where do I start?

In order to provision a cluster, a couple of items have to be in place:

1) AWS account credentials must be present (aws_access_key, aws_secret_key)
2) In order to route traffic to the cluster, you need a public zone file and doamin configured in `AWS Route53`.
3) Create a SSH key file in the AWS console, and place the public key in e.g. `~/.ssh`. See [My Security Credentials](https://console.aws.amazon.com/iam/home#/security_credential).
4) Prepare your `inventory file` by making a copy of e.g. `inventory/inventory_small.example`.
5) Modify your inventory file to match your needs.
6) Created a pre-built AMI. To speed in the provisioning of medium and large clusters, a pre-built AMI is used.


### TL;DR - Let's Provision!

**WARNING:** Running these plays will provision items in your AWS account, and you may incur billing charges. These plays are not suitable for the AWS free-tier.

More details on each step can be found in later sections ... let's provision a cluster !

#### Step 1 - Prepare the Inventory

Make a copy of e.g. `inventory/inventory_small.example` and give it a unique name e.g. `inventory/inventory_eu_west`. At minimum, the following variables MUST be changed:

```yaml
vars:
  # AWS access key
  aws_access_key: AKI...
  aws_secret_key: 7te...
  # The AWS region to deploy to
  region: eu-west-1
  # AWS keyname and local keyfile location
  key_name: openshift
  ansible_ssh_private_key_file: ~/.ssh/openshift.pem
  # Public DNS zone setup
  namespace: openshift
  public_dns_zone: example.com
```

Changing all other variables is OPTIONAL. More configuration options can be found in file `playbooks/group_vars/all`.

#### Step 2 - Create the AMI

Start the creation of the pre-built AMI:

```shell
ansible-playbook -i inventory/<your_inventory_file> playbooks/build_ami.yml
```

#### Step 3 - Create the Bastion Host

OpenShift is not provisioned from your local machine, but requires a `bastion host`:

```shell
ansible-playbook -i inventory/<your_inventory_file> playbooks/provision_bastion.yml
```

#### Step 4 - Create the infrastructure

Create all AWS assets (vpc, security groups, EC2 instances, DNS entries etc.):

```shell
ansible-playbook -i inventory/<your_inventory_file> playbooks/provision.yml
```

#### Step 5 - Create the cluster

Log into the bastion host:

```shell
ssh -i ~/.ssh/openshift.pem centos@bastion.openshift.example.com
```

Replace `openshift.example.com` with your namespace and public domain !

Start the cluster provisioning:

```shell
./install-openshift.sh
```

The creation of large cluster (infrastructure and OpenShift) will take aproximately 45 minutes.

### Stop the Cluster and de-provision the infrastructure

**WARNING:** Running the teardown plays will DESTROY ALL DATA in the cluster!

Remove the OpenShift cluster:

```shell
ansible-playbook -i inventory/<your_inventory_file> playbooks/teardown.yml
```

Remove the bastion host:

```shell
ansible-playbook -i inventory/<your_inventory_file> playbooks/teardown_bastion.yml
```

### Configuration

#### Cluster Types

The playbooks support the following three types of clusters:

* Small - 1 Master Node, 1 .. n App Nodes
* Medium - 1 Master Node, 1 Infra Node, 1 .. n App Nodes
* Large - 3 Master Nodes, 2 Infra Nodes, 1 Load Balancer, 4 .. n App Nodes

The type of cluster to provision depends on the following variables in your inventory file:

```yaml
vars:
  # Cluster size
  master_nodes: 1
  infra_nodes: 0
  app_nodes: 1
```

The following rules decide on the cluster type:

| master_nodes | infra_nodes | app_nodes | Cluster Type |
|--------------|-------------|-----------|--------------|
|      1       |      0      |  1 .. n   |  SMALL       |
|      1       |      1,2    |  1 .. n   |  MEDIUM      |
|      3       |      2 ..   |  3 .. n   |  LARGE       |


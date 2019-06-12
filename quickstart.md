# Helper Node Quickstart Install

This quickstart will get you up and running on `libvirt`. This should work on other environments (i.e. Virtualbox); you just have to figure out how to do the virtual network on your own.

## Create Virtual Network

Create a virtual network using the [virt-net.xml](./virt-net.xml) file provided in this repo (modify it if you wish).

```
virsh net-define --file virt-net.xml
```

Make sure you set it to autostart on boot

```
virsh net-autostart openshift4
virsh net-start openshift4
```

## Create a CentOS 7 VM

Create a CentOS 7 VM with the following characteristics

* 2 CPUs
* 4 GB RAM
* 30 GB HD
* Attached to the `openshift4` network
* Static IP address with DNS pointing to 8.8.8.8

If you're using the provided `virt-net.xml` file; use the following

* IP - 192.168.7.77
* NetMask - 255.255.255.0
* Default Gateway - 192.168.7.1
* DNS Server - 8.8.8.8

## Create "empty" VMs

Create (but do NOT install) 6 empty VMs. 3 for the control plane, 1 for the bootstrap and 2 for the workers. 

Please follow the [min requirements](https://docs.openshift.com/container-platform/4.1/installing/installing_bare_metal/installing-bare-metal.html#minimum-resource-requirements_installing-bare-metal) for these VMs. 

Make sure you attached these to the `openshift4` network

## Prepare the Helper Node

Install `ansible` and `git` and clone this repo

```
yum -y install ansible git
git clone https://github.com/christianh814/ocp4-upi-helpernode
cd ocp4-upi-helpernode
```

Edit the `vars.yaml` file with the mac addresses of the "blank" VMs

## Run the playbook

Run the playbook to setup your helper node

```
ansible-playbook -e @vars.yaml tasks/main.yml
```

After it is done run the following to get info about your node


```
/usr/local/bin/checker.sh
```

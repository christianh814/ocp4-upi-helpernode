# OCP4 UPI Helper Node Playbook

> You can visit the [quickstart](docs/quickstart.md) to get right on it and start

This assumes the following

1. You're on a Network that has access to the internet
2. The network you're on does NOT have DHCP
3. The helpernode will be your LB/DHCP/PXE/DNS and HTTPD server
4. You still have to do the OpenShift Install steps by hand (this just sets up the node to help you)
5. I used CentOS 7
6. You will be running the `openshift-install` command from this helpernode

![helpernode](docs/images/hn.jpg)


It's important to note that you can delegate DNS to this helpernode if you don't want to use it as your main DNS server. You will have to delegate `$CLUSTERID.$DOMAIN` to this helper node.

For example; if you want a `$CLUSTERID` of **ocp4**, and a `$DOMAIN` of **example.com**. Then you will delegate `ocp4.example.com` to this helpernode.

## Prereqs

> **NOTE** If using RHEL 7, you will need to enable the `rhel-7-server-rpms` and the `rhel-7-server-extras-rpms` repos. [EPEL](https://fedoraproject.org/wiki/EPEL) is also recommended for RHEL 7.

Install a CentOS 7 server with this recommended setup:

* 4 vCPUs
* 4 GB of RAM
* 30GB HD
* Static IP

Then prepare for the install

```
yum -y install ansible git
git clone https://github.com/christianh814/ocp4-upi-helpernode
cd ocp4-upi-helpernode
```

## Setup your Environment Vars

Inside that dir there is a [vars.yaml](docs/examples/vars.yaml) file ... **__modify it__** to match your network (the example one assumes a `/24`)

> **NOTE** See the `vars.yaml` [documentaion page](docs/vars-doc.md) for more info about what it does.


## Run the playbook

Once you edited your `vars.yaml` file; run the playbook

```
ansible-playbook -e @vars.yaml tasks/main.yml
```

## Helper Script

You can run this script and it's options to display helpful information about the install.

```
/usr/local/bin/helpernodecheck
```

## Install OpenShift 4 UPI

Now you're ready to follow the [OCP4 UPI install doc](https://docs.openshift.com/container-platform/4.2/installing/installing_bare_metal/installing-bare-metal.html#ssh-agent-using_installing-bare-metal)



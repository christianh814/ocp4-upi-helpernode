# OCP4 UPI Helper Node Playbook

This assumes the following

1. You're on a Network that has access to the internet
2. The network you're on does NOT have DHCP
3. The helpernode will be your LB/DHCP/DNS and HTTPD server
4. You still have to do the OpenShift Install steps by hand (this just sets up the node to help you)
5. I used CentOS 7


To use this...install a CentOS 7 server with 4 vCPUs, 4 GB of RAM, and 50GB HD...then....

```
yum -y install ansible git
git clone https://github.com/christianh814/ocp4-upi-helpernode
cd ocp4-upi-helpernode
```

Inside that dir there is a `vars.yaml` ...modify it to match your network (the example one assumes a `/24`


Run the playbook

```
ansible-playbook -e @vars.yaml tasks/main.yml
```

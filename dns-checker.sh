#!/bin/bash
domain=$1
clusterid=$2
if [[ ${#domain} -eq 0 ]] || [[ ${#clusterid} -eq 0 ]]; then
  echo "Usage: $(basename $0) <domain> <clusterid>"
  exit
fi
#
echo "Foward lookup"
echo "============="
for name in m{1..3} w{1..3} boostrap etcd-{0..2} foo.apps api api-int
do
  echo -n "${name}.${clusterid}.${domain}				"
  dig @localhost ${name}.${clusterid}.${domain} +short
done
echo "Reverse lookup"
echo "=============="
for name in m{1..3} w{1..3} boostrap etcd-{0..2} foo.apps api api-int
do
  echo -n "$(dig @localhost ${name}.${clusterid}.${domain} +short)                               "
  dig @localhost -x $(dig @localhost ${name}.${clusterid}.${domain} +short) +short
done
echo "SRV Records"
echo "==========="
dig @localhost _etcd-server-ssl._tcp.${clusterid}.${domain} SRV +short
echo ""
##
##

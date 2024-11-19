#!/bin/sh
# sed commands that modify network/storage bus for vms that cannot use virtio (e.g. rhel 6)
# to get yaml that this script modifies run `oc get vm -o yaml > vms.yaml`.

sed -i -r 's/^(\s{16,})bus: virtio$/\1bus: sata/g' $1
sed -i -r 's/(\s+)model: virtio/\1model: e1000e/g' $1

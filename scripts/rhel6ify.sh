sed -i -r 's/^(\s{16,})bus: virtio$/\1bus: sata/g' $1
sed -i -r 's/(\s+)model: virtio/\1model: e1000e/g' $1

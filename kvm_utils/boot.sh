#!/bin/bash

IMG="focal-server-cloudimg-amd64.img"
SEED="seed.img"

if [ ! -e "$IMG" ]; then
	echo "Img not exist."
    echo "run $ 'wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img' to get the ''cloud'' image."
	exit 1
fi

if [ ! -e "$SEED" ]; then
	echo "seed does not exist. Run genseed.sh"
fi

set -x
qemu-system-x86_64 \
  -drive "file=$IMG,format=qcow2" \
  -drive "file=$SEED,format=raw" \
  -device rtl8139,netdev=net0 \
  -enable-kvm \
  -m 2G \
  -netdev user,id=net0 \
  -serial mon:stdio \
  -smp 5
  -nic tap,model=virtio

#!/bin/bash

IMG="focal-server-cloudimg-amd64.img"
TARGET_IMG="fallback-cloudimg.img"
SEED="seed.img"


if [ ! -e "../../isos/$IMG" ]; then
    echo "Img not exist."
    echo "run $ 'wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img' to get the \"cloud\" image, and move it into the isos directory."
    exit 1
fi

if [ ! -e "$SEED" ]; then
	echo "seed does not exist. Run genseed.sh"
fi

echo "set the image name which qemu will write into(please add filename extemsion like *.img), notice it will overwrite the file at that directory"
read TMP_TARGET_IMG
if [[ $TMP_TARGET_IMG != "" ]]; then
    TARGET_IMG=$TMP_TARGET_IMG
fi

cp "../../isos/$IMG" "../../isos/$TARGET_IMG"

set -x
qemu-system-x86_64 \
  -drive "file=../../isos/$TARGET_IMG,format=qcow2" \
  -drive "file=$SEED,format=raw" \
  -device rtl8139,netdev=net0 \
  -enable-kvm \
  -m 2G \
  -netdev user,id=net0 \
  -serial mon:stdio \
  -smp 5
  -nic tap,model=virtio

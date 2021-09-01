#!/bin/bash

IMG="focal-server-cloudimg-amd64.img"
TARGET_IMG="fallback-cloudimg"
SEED="seed.img"


if [ ! -e "../../isos/$IMG" ]; then
    echo "Img not exist."
    echo "run $ 'wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img' to get the \"cloud\" image, and move it into the isos directory."
    exit 1
fi

if [ ! -e "$SEED" ]; then
    echo "seed does not exist. Run genseed.sh"
fi

echo "set the image name which qemu will write into(please not add filename extemsion like *.img), notice it will overwrite the file at that directory"
read TMP_TARGET_IMG
if [[ $TMP_TARGET_IMG != "" ]]; then
    TARGET_IMG=$TMP_TARGET_IMG
fi

cp "../../isos/$IMG" "../../isos/$TARGET_IMG.img"

virt-install \
  --name $TARGET_IMG \
  --memory 2048 \
  --disk "../../isos/$TARGET_IMG.img",device=disk,bus=virtio \
  --disk $SEED,device=cdrom \
  --os-type linux \
  --os-variant ubuntu20.04 \
  --virt-type kvm \
  --graphics none \
  --network network=default,model=virtio \
  --import

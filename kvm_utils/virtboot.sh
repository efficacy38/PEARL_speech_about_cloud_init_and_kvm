#!/bin/bash

IMG="focal-server-cloudimg-amd64.img"
TARGET_IMG="fallback-cloudimg"
SEED="seed.img"
CORE=2
MEMORY=4096

function promptAndGetVal() {
    prompt=$1
    local -n argRef=$2
    unset input
    echo $prompt
    read input
    if [[ $input != "" ]]; then
        argRef=$input
    fi
}

if [ ! -e "../../isos/$IMG" ]; then
    echo "Img not exist."
    echo "run $ 'wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img' to get the \"cloud\" image, and move it into the isos directory."
    exit 1
fi

if [ ! -e "$SEED" ]; then
    echo "seed does not exist. Run genseed.sh"
fi

promptAndGetVal "set the image name which qemu will write into(please not add filename extemsion like *.img), notice it will overwrite the file at that directory" TARGET_IMG
promptAndGetVal "set the vcpus default is 2" CORE
promptAndGetVal "set the memory default is 4096(G)" MEMORY
echo "local-hostname: $TARGET_IMG" >> metadata.yaml
./genseed.sh

cp "../../isos/$IMG" "../../isos/$TARGET_IMG.img"

echo "$TARGET_IMG|$CORE|$MEMORY"

virt-install \
  --name $TARGET_IMG \
  --memory $MEMORY \
  --vcpus $CORE \
  --disk "../../isos/$TARGET_IMG.img",device=disk,bus=virtio \
  --disk $SEED,device=cdrom \
  --os-type linux \
  --os-variant ubuntu20.04 \
  --virt-type kvm \
  --graphics none \
  --network network=default,model=virtio \
  --import

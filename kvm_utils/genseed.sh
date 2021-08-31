#!/bin/bash

set -u

SEED="seed.img"

if [ -e "$SEED" ]; then
    rm "$SEED"
fi

# this seed image commonly be foramat as vfat or iso9960(it would be labeled as cidata and called as configuration drive)
# following may generate a iso9960 format, use -f or --filesystem to change the format (vfat and iso9960)
cloud-localds -v "$SEED" userdata.yaml metadata.yaml

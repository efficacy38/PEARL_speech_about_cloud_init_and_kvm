#!/bin/bash

set -u

SEED="seed.img"

if [ -e "$SEED" ]; then
    rm "$SEED"
fi

cloud-localds -v "$SEED" userdata.yaml metadata.yaml

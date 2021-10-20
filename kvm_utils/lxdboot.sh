#!/bin/bash
# set -x

TARGET_IMG="fallback-cloudimg"

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
promptAndGetVal "set the container name which qemu will write into(please not add filename extemsion like *.img), notice it will overwrite the file at that directory" TARGET_IMG
echo "local-hostname: $TARGET_IMG" >> metadata.yaml

# if using falback, just delete the lxc container record about old CT
lxc delete -f $TARGET_IMG 
lxc launch ubuntu-daily:focal $TARGET_IMG --config=user.user-data="$(cat userdata.yaml)" --config=user.meta-data="$(cat metadata.yaml)"
lxc exec $TARGET_IMG bash

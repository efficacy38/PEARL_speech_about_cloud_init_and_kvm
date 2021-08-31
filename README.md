# PEARL_speech_about_cloud_init_and_kvm

## utils
### <span>boot.sh</span>
can use this shell to boot a virtual machine with qemu, and need to input the generated image name while using the shell.

### <span>genseed.sh</span>
can use this shell to generate the seed file aka configure driver(in openstack)

### <span>transform.sh</span>
give some reminder to transform virtual hard disk driver (qcow2 -> vmdk)

## demos
which contain some examples, demostrate the cloud init's feature, and some application.]
### files in demo
- userdata.yaml
    - as cloud-init's userdata
- metadata.yaml
    - as cloud-init's metadata
    - as openstack's metadata service

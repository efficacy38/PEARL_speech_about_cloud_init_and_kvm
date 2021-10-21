# convert qcow2 to vmdk
qemu-img convert -f qcow2 myImage.qcow2 -O vmdk myNewImage.vmdk 

# transform vmdk to fit the current size
vmkfstools -i myImage.vmdk outputName.vmdk -d thin

# refer from https://stackoverflow.com/questions/37794846/convert-qcow2-to-vmdk-and-make-it-esxi-6-0-compatible

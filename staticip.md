#clone the repo
git clone https://github.com/ipxe/ipxe.git

kernel: rhcos-<version>-live-kernel-<architecture>

initramfs: rhcos-<version>-live-initramfs.<architecture>.img

rootfs: rhcos-<version>-live-rootfs.<architecture>.img
  
 example:
 
 https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.6/latest/
 
 kernel: https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.6/latest/rhcos-4.6.8-x86_64-live-kernel-x86_64

initramfs: https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.6/latest/rhcos-4.6.8-x86_64-live-initramfs.x86_64.img

rootfs: https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.6/latest/rhcos-4.6.8-x86_64-live-rootfs.x86_64.img

IPXE: deps
https://ipxe.org/download


```
#create iso file for use
make bin/ipxe.iso EMBED=./coreos-amd64-installer.ipxe 

#create bootable iso for vmware
make bin/8086100f.mrom bin/808610d3.mrom bin/10222000.rom bin/15ad07b0.rom bin/ipxe.iso EMBED=./coreos-amd64-installer.ipxe

#create usb bootable
make bin/ipxe.usb EMBED=./coreos-amd64-installer.ipxe 

#transfer the usb image to your usbdisk
#Note: XX is your usbdevice id.
dd if=bin/ipxe.usb of=/dev/sdXX
```

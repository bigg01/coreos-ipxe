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


```
cd ipxe/src
cat >coreos-amd64-installer.ipxe <<EOF
#!ipxe
#static ip settings
ifopen net0
set net0/ip 192.168.1.240
set net0/netmask 255.255.255.0
set net0/gateway 192.168.1.1
set dns 192.168.1.1
set hostname puppet1
set domain_name domain.local
#dhcp

echo "Configured IP Details:"
show net0/ip
show net0/netmask
show net0/gateway
show dns
show hostname
show domain_name
route


#Coreos 
set menutimeout 5
echo Starting CoreOS x64 installer for ${hostname}
set base-url http://192.168.122.1:8000
kernel ${base-url}/fedora-coreos-31.20200310.3.0-live-kernel-x86_64 ip=dhcp rd.neednet=1 console=tty0 ignition.firstboot ignition.platform.id=metal ignition.config.url=https://dustymabe.com/2020-04-04/automated_install.ign
initrd ${base-url}/fedora-coreos-31.20200310.3.0-live-initramfs.x86_64.img
boot


#set menutimeout 5
#echo Starting Ubuntu x64 installer for ${hostname}
#set base-url http://archive.ubuntu.com/ubuntu/dists/trusty/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64
#kernel ${base-url}/linux priority=critical
#initrd ${base-url}/initrd.gz
#NOTE: make sure you update the LOCAL_NETWORK_IP and preseed file present there
#imgargs linux auto=true url=http://LOCAL_NETWORK_IP/preseed.cfg interface=eth0 hostname=${hostname} domain=${domain_name} netcfg/disable_dhcp=true #netcfg/get_ipaddress=${net0/ip} netcfg/get_netmask=${net0/netmask} netcfg/get_gateway=${net0/gateway} netcfg/get_nameservers=${dns}
boot || 

# If everything failed, give the user some options
echo Boot from ${base-url} failed
prompt --key 0x197e --timeout 2000 Press F12 to investigate || exit
shell
EOF

#create iso file for use
make bin/ipxe.iso EMBED=./ubuntu-amd64-installer.ipxe 

#create bootable iso for vmware
make bin/8086100f.mrom bin/808610d3.mrom bin/10222000.rom bin/15ad07b0.rom bin/ipxe.iso EMBED=./ubuntu-amd64-installer.ipxe

#create usb bootable
make bin/ipxe.usb EMBED=./ubuntu-amd64-installer.ipxe 

#transfer the usb image to your usbdisk
#Note: XX is your usbdevice id.
dd if=bin/ipxe.usb of=/dev/sdXX
```

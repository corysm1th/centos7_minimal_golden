# Steps to Create CentOS 7 "Golden Image"
Configuration I use on top of CentOS 7 minimal install

- OS Disk >= 50 GB
- Encrypted root partition
- Software Selection: Minimal Install

Bring up the network.  This needs to be done manually, or added to kickstart or packer.
```sh
sed -i 's/ONBOOT=no/ONBOOT=yes/' /etc/sysconfig/network-scripts/ifcfg-*
systemctl restart network
```

Continue with 001_bootstrap.sh
```sh
curl https://raw.githubusercontent.com/corysm1th/centos7_minimal_golden/master/001_bootstrap.sh | sh
```

Finish configuring your image:
- ssh keys?
- virtual machine drivers?
- other configurations.

Sanitize for cloning
```sh
curl https://raw.githubusercontent.com/corysm1th/centos7_minimal_golden/master/999_sanitize.sh | sh
```

# runonce_setup.sh
Framework for running scripts once on next reboot, based on a stackexchange post by [Dennis Williamson](https://github.com/dtwilliamson):
https://serverfault.com/a/148355/368069

Run the runonce_setup.sh script to build the framework.

Copy any script to /etc/local/runonce.d/ and it will run once on the next reboot.

# virtualbox_guest_additions.sh
Installs virtualbox guest additions on Centos 7 with minimal install.

Insert the VirtualBox Guest Additions ISO into the virtual CD-ROM drive, and run this:

```sh
curl https://raw.githubusercontent.com/corysm1th/centos7_minimal_golden/master/virtualbox_guest_additions.sh | sh
```

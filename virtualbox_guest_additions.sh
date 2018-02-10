#!/bin/sh
if ! (blkid /dev/cdrom >/dev/null) ; then
    echo "Insert Virtualbox Guest Additions ISO file"
    exit 1
fi

yum install -y bzip2 dkms gcc kernel-devel make
mount -t iso9660 /dev/cdrom /media
/media/VBoxLinuxAdditions.run
umount /media

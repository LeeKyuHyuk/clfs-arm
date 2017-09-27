#!/bin/bash
set -o nounset
set -o errexit

make toolchain -C $PACKAGES_DIR/makedevs

$STEP "Creating clfs home directory."
mkdir -pv $ROOTFS_DIR/home/clfs

$STEP "Creating the fstab"
rm -f $ROOTFS_DIR/etc/fstab
cat > $ROOTFS_DIR/etc/fstab << "EOF"
# Begin /etc/fstab
# <file system>	<mount pt>	<type>	<options>	<dump>	<pass>
/dev/mmcblk0   /            ext2     defaults,noatime,nodiratime 0     2
#/swapfile     swap         swap     pri=1                       0     0
proc           /proc        proc     nosuid,noexec,nodev         0     0
sysfs          /sys         sysfs    nosuid,noexec,nodev         0     0
devpts         /dev/pts     devpts   gid=5,mode=620              0     0
tmpfs          /run         tmpfs    defaults                    0     0
devtmpfs       /dev         devtmpfs mode=0755,nosuid            0     0
# End /etc/fstab
EOF

rm -f $BUILD_DIR/_fakeroot.fs
echo '#!/bin/sh' > $BUILD_DIR/_fakeroot.fs
echo "set -e" >> $BUILD_DIR/_fakeroot.fs
echo "chown -h -R 0:0 $ROOTFS_DIR" >> $BUILD_DIR/_fakeroot.fs
cat $SUPPORT_DIR/device_table.txt > $BUILD_DIR/_device_table.txt
if [ -f $ROOTFS_DIR/usr/bin/sudo ] ; then
echo "/usr/bin/sudo	f	4755	0	0	-	-	-	-	-" >> $BUILD_DIR/_device_table.txt
fi
if [ -d $ROOTFS_DIR/home/clfs ] ; then
echo "/home/clfs	d	755	1000	1000	-	-	-	-	-" >> $BUILD_DIR/_device_table.txt
fi
if [ -d $ROOTFS_DIR/var/lib/ntp ] ; then
echo "/var/lib/ntp	d	755	87	87	-	-	-	-	-" >> $BUILD_DIR/_device_table.txt
fi
if [ -d $ROOTFS_DIR/var/lib/sshd ] ; then
echo "/var/lib/sshd	d	700	0	2	-	-	-	-	-" >> $BUILD_DIR/_device_table.txt
fi
if [ -d $ROOTFS_DIR/usr/libexec/dbus-daemon-launch-helper ] ; then
echo "/usr/libexec/dbus-daemon-launch-helper	d	4750	0	18	-	-	-	-	-" >> $BUILD_DIR/_device_table.txt
fi
echo "$TOOLS_DIR/bin/makedevs -d $BUILD_DIR/_device_table.txt $ROOTFS_DIR" >> $BUILD_DIR/_fakeroot.fs
echo "$TOOLS_DIR/sbin/mkfs.ext2 -d $ROOTFS_DIR -r 1 -N 0 -m 5 $IMAGES_DIR/rootfs.ext2 2000M" >> $BUILD_DIR/_fakeroot.fs
chmod a+x $BUILD_DIR/_fakeroot.fs
$TOOLS_DIR/bin/fakeroot -- $BUILD_DIR/_fakeroot.fs

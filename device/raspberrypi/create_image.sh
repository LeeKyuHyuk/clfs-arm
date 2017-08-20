#!/bin/bash
set -o nounset
set -o errexit

$STEP "Creating the fstab"
rm -f $ROOTFS_DIR/etc/fstab
cat > $ROOTFS_DIR/etc/fstab << "EOF"
# Begin /etc/fstab
# <file system>	<mount pt>	<type>	<options>	<dump>	<pass>
/dev/mmcblk0p1 /boot        vfat     defaults                    0     1
/dev/mmcblk0p2 /            ext4     defaults,noatime,nodiratime 0     2
#/swapfile     swap         swap     pri=1                       0     0
proc           /proc        proc     nosuid,noexec,nodev         0     0
sysfs          /sys         sysfs    nosuid,noexec,nodev         0     0
devpts         /dev/pts     devpts   gid=5,mode=620              0     0
tmpfs          /run         tmpfs    defaults                    0     0
devtmpfs       /dev         devtmpfs mode=0755,nosuid            0     0
# End /etc/fstab
EOF

$STEP "Creating the clock"
rm -rf $ROOTFS_DIR/etc/sysconfig/clock
cat > $ROOTFS_DIR/etc/sysconfig/clock << "EOF"
# Begin /etc/sysconfig/clock

UTC=1

# Set this to any options you might need to give to hwclock,
# such as machine hardware clock type for Alphas.
CLOCKPARAMS=

# End /etc/sysconfig/clock
EOF

$STEP "Creating the fake-hwclock.data"
echo `date +%Y-%m-%d\ %H:%M:%S` > $ROOTFS_DIR/etc/fake-hwclock.data

rm -f $BUILD_DIR/_fakeroot.fs
echo '#!/bin/sh' > $BUILD_DIR/_fakeroot.fs
echo "set -e" >> $BUILD_DIR/_fakeroot.fs
echo "chown -h -R 0:0 $ROOTFS_DIR" >> $BUILD_DIR/_fakeroot.fs
cat $SUPPORT_DIR/device_table.txt > $BUILD_DIR/_device_table.txt
if [ -d $ROOTFS_DIR/var/log/lastlog ] ; then
  echo "/var/log/lastlog	d	664	13	13	-	-	-	-	-" >> $BUILD_DIR/_device_table.txt
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
echo "$TOOLS_DIR/usr/bin/makedevs -d $BUILD_DIR/_device_table.txt $ROOTFS_DIR" >> $BUILD_DIR/_fakeroot.fs
echo "$TOOLS_DIR/usr/sbin/mkfs.ext2 -d $ROOTFS_DIR $IMAGES_DIR/rootfs.ext2 2000M" >> $BUILD_DIR/_fakeroot.fs
chmod a+x $BUILD_DIR/_fakeroot.fs
$TOOLS_DIR/usr/bin/fakeroot -- $BUILD_DIR/_fakeroot.fs
ln -svf rootfs.ext2 $IMAGES_DIR/rootfs.ext4
mkdir -p $IMAGES_DIR/kernel-marked
for dtb in $CONFIG_LINUX_KERNEL_INTREE_DTS_NAME ; do \
	cp -v $KERNEL_DIR/${dtb}.dtb $IMAGES_DIR ; \
done
chmod 755 $DEVICE_DIR/raspberrypi/mkknlimg
$DEVICE_DIR/raspberrypi/mkknlimg $KERNEL_DIR/zImage $IMAGES_DIR/kernel-marked/zImage
mkdir -v $IMAGES_DIR/rpi-firmware
install -Dv -m 0644 $DEVICE_DIR/raspberrypi/boot/bootcode.bin $IMAGES_DIR/rpi-firmware/bootcode.bin
install -Dv -m 0644 $DEVICE_DIR/raspberrypi/boot/start"".elf $IMAGES_DIR/rpi-firmware/start.elf
install -Dv -m 0644 $DEVICE_DIR/raspberrypi/boot/fixup"".dat $IMAGES_DIR/rpi-firmware/fixup.dat
if [ "$CONFIG_NAME" = "raspberrypi3" ] ; then \
 cp -Rv $DEVICE_DIR/raspberrypi/boot/overlays $IMAGES_DIR/rpi-firmware/overlays; \
fi;
install -Dv -m 0644 $DEVICE_DIR/raspberrypi/config.txt $IMAGES_DIR/rpi-firmware/config.txt
if [ "$CONFIG_NAME" = "raspberrypi3" ] ; then \
	if ! grep -qE '^dtoverlay=' "$IMAGES_DIR/rpi-firmware/config.txt" ; then \
		$STEP "Adding 'dtoverlay=pi3-miniuart-bt' to config.txt (fixes ttyAMA0 serial console)." ; \
		echo "# fixes rpi3 ttyAMA0 serial console" >> $IMAGES_DIR/rpi-firmware/config.txt ; \
		echo "dtoverlay=pi3-miniuart-bt" >> $IMAGES_DIR/rpi-firmware/config.txt ; \
	fi ; \
fi;
echo "dwc_otg.lpm_enable=0 console=ttyAMA0,115200 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait ip=dhcp rootdelay=5" > $IMAGES_DIR/rpi-firmware/cmdline.txt
$TOOLS_DIR/usr/bin/genimage \
--rootpath "$ROOTFS_DIR" \
--tmppath "$BUILD_DIR/genimage.tmp" \
--inputpath "$IMAGES_DIR" \
--outputpath "$IMAGES_DIR" \
--config "$DEVICE_DIR/raspberrypi/$CONFIG_NAME.cfg"

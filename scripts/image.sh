#!/bin/bash
set -o nounset
set -o errexit

rm -f $BUILD_DIR/_fakeroot.fs
rm -f $BUILD_DIR/_users_table.txt
echo '#!/bin/sh' > $BUILD_DIR/_fakeroot.fs
echo "set -e" >> $BUILD_DIR/_fakeroot.fs
echo "chown -h -R 0:0 $ROOTFS_DIR" >> $BUILD_DIR/_fakeroot.fs
cat $SUPPORT_DIR/device_table.txt > $BUILD_DIR/_device_table.txt
if [ -d $BUILD_DIR/var/log/lastlog ] ; then
  echo "/var/log/lastlog	d	664	13	13	-	-	-	-	-" >> $BUILD_DIR/_device_table.txt
fi
if [ -d $BUILD_DIR/var/lib/ntp ] ; then
echo "/var/lib/ntp	d	755	87	87	-	-	-	-	-" >> $BUILD_DIR/_device_table.txt
fi
if [ -d $BUILD_DIR/var/lib/sshd ] ; then
echo "/var/lib/sshd	d	700	0	2	-	-	-	-	-" >> $BUILD_DIR/_device_table.txt
fi
if [ -d $BUILD_DIR/usr/libexec/dbus-daemon-launch-helper ] ; then
echo "/usr/libexec/dbus-daemon-launch-helper	d	4750	0	18	-	-	-	-	-" >> $BUILD_DIR/_device_table.txt
fi
echo "$TOOLS_DIR/usr/bin/makedevs -d $BUILD_DIR/_device_table.txt $ROOTFS_DIR" >> $BUILD_DIR/_fakeroot.fs
echo "$TOOLS_DIR/usr/bin/mke2img -d $ROOTFS_DIR -G 2 -R 1 -b 1256960 -I 0 -o $IMAGES_DIR/rootfs.ext2" >> $BUILD_DIR/_fakeroot.fs
chmod a+x $BUILD_DIR/_fakeroot.fs
$TOOLS_DIR/usr/bin/fakeroot -- $BUILD_DIR/_fakeroot.fs

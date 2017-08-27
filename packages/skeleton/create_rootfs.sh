#!/bin/bash
$STEP "Create root file system directory."
mkdir -pv $ROOTFS_DIR/{dev,proc,sys,run}
mkdir -pv $ROOTFS_DIR/{bin,boot,etc/{opt,sysconfig},home,lib/firmware,mnt,opt}
mkdir -pv $ROOTFS_DIR/{media/{floppy,cdrom},sbin,srv,var}
install -dv -m 0750 $ROOTFS_DIR/root
install -dv -m 1777 $ROOTFS_DIR/tmp $ROOTFS_DIR/var/tmp
mkdir -pv $ROOTFS_DIR/usr/{,local/}{bin,include,lib,sbin,src}
mkdir -pv $ROOTFS_DIR/usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -v $ROOTFS_DIR/usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -v $ROOTFS_DIR/usr/libexec
mkdir -pv $ROOTFS_DIR/usr/{,local/}share/man/man{1..8}
mkdir -v $ROOTFS_DIR/var/{log,mail,spool}
ln -svf /run $ROOTFS_DIR/var/run
ln -svf /run/lock $ROOTFS_DIR/var/lock
mkdir -pv $ROOTFS_DIR/var/{opt,cache,lib/{color,misc,locate},local}

$STEP "Creating Essential Files and Symlinks"
ln -sv /proc/self/mounts $ROOTFS_DIR/etc/mtab
cat > $ROOTFS_DIR/etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/bin/false
daemon:x:6:6:Daemon User:/dev/null:/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/var/run/dbus:/bin/false
systemd-bus-proxy:x:72:72:systemd Bus Proxy:/:/bin/false
systemd-journal-gateway:x:73:73:systemd Journal Gateway:/:/bin/false
systemd-journal-remote:x:74:74:systemd Journal Remote:/:/bin/false
systemd-journal-upload:x:75:75:systemd Journal Upload:/:/bin/false
systemd-network:x:76:76:systemd Network Management:/:/bin/false
systemd-resolve:x:77:77:systemd Resolver:/:/bin/false
systemd-timesync:x:78:78:systemd Time Synchronization:/:/bin/false
systemd-coredump:x:79:79:systemd Core Dumper:/:/bin/false
nobody:x:99:99:Unprivileged User:/dev/null:/bin/false
EOF
cat > $ROOTFS_DIR/etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
usb:x:14:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
systemd-journal:x:23:
input:x:24:
mail:x:34:
systemd-bus-proxy:x:72:
systemd-journal-gateway:x:73:
systemd-journal-remote:x:74:
systemd-journal-upload:x:75:
systemd-network:x:76:
systemd-resolve:x:77:
systemd-timesync:x:78:
systemd-coredump:x:79:
nogroup:x:99:
users:x:999:
EOF
cat > $ROOTFS_DIR/etc/passwd << "EOF"
root::10933:0:99999:7:::
daemon:*:10933:0:99999:7:::
bin:*:10933:0:99999:7:::
sys:*:10933:0:99999:7:::
sync:*:10933:0:99999:7:::
mail:*:10933:0:99999:7:::
www-data:*:10933:0:99999:7:::
operator:*:10933:0:99999:7:::
nobody:*:10933:0:99999:7:::
EOF
touch $ROOTFS_DIR/var/log/{btmp,lastlog,faillog,wtmp}
echo "127.0.0.1 localhost $CONFIG_HOSTNAME" > $ROOTFS_DIR/etc/hosts
echo "$CONFIG_HOSTNAME" > $ROOTFS_DIR/etc/hostname
echo "LANG=\"en_US.UTF-8\"" > $ROOTFS_DIR/etc/locale.conf
cat > $ROOTFS_DIR/etc/inputrc << "EOF"
# Begin /etc/inputrc
# Modified by Chris Lynn <roryo@roryo.dynup.net>

# Allow the command prompt to wrap to the next line
set horizontal-scroll-mode Off

# Enable 8bit input
set meta-flag On
set input-meta On

# Turns off 8th bit stripping
set convert-meta Off

# Keep the 8th bit for display
set output-meta On

# none, visible or audible
set bell-style none

# All of the following map the escape sequence of the value
# contained in the 1st argument to the readline specific functions
"\eOd": backward-word
"\eOc": forward-word

# for linux console
"\e[1~": beginning-of-line
"\e[4~": end-of-line
"\e[5~": beginning-of-history
"\e[6~": end-of-history
"\e[3~": delete-char
"\e[2~": quoted-insert

# for xterm
"\eOH": beginning-of-line
"\eOF": end-of-line

# for Konsole
"\e[H": beginning-of-line
"\e[F": end-of-line

# End /etc/inputrc
EOF

cat > $ROOTFS_DIR/etc/shells << "EOF"
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
EOF

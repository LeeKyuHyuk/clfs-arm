#!/bin/bash
$STEP "Create root file system directory."
mkdir -pv $ROOTFS_DIR/{dev,proc,sys,run}
mkdir -pv $ROOTFS_DIR/{bin,boot,etc/{opt,sysconfig},home,lib/firmware,mnt,opt}
mkdir -pv $ROOTFS_DIR/{media/{floppy,cdrom},sbin,srv,var}
install -dv -m 0750 $ROOTFS_DIR/root
install -dv -m 1777 $ROOTFS_DIR/tmp $ROOTFS_DIR/var/tmp
mkdir -pv $ROOTFS_DIR/usr/{,local/}{bin,include,lib,sbin,src}
mkdir -pv $ROOTFS_DIR/usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -v  $ROOTFS_DIR/usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -v  $ROOTFS_DIR/usr/libexec
mkdir -pv $ROOTFS_DIR/usr/{,local/}share/man/man{1..8}
mkdir -v $ROOTFS_DIR/var/{log,mail,spool}
ln -svf /run $ROOTFS_DIR/var/run
ln -svf /run/lock $ROOTFS_DIR/var/lock
mkdir -pv $ROOTFS_DIR/var/{opt,cache,lib/{color,misc,locate},local}
touch $ROOTFS_DIR/var/log/{btmp,lastlog,faillog,wtmp}
chmod -v 664  $ROOTFS_DIR/var/log/lastlog
chmod -v 600  $ROOTFS_DIR/var/log/btmp
$STEP "Creating Essential Files and Symlinks"
ln -svf /proc/self/mounts $ROOTFS_DIR/etc/mtab
$STEP "Creating the passwd, shadow, group, and log File"
cat > $ROOTFS_DIR/etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/bin/false
daemon:x:6:6:Daemon User:/dev/null:/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/var/run/dbus:/bin/false
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
nogroup:x:99:
users:x:999:
EOF
cat > $ROOTFS_DIR/etc/shadow << "EOF"
root:.wp1ih7ShybZM:0:0:99999:7:::
EOF
sed -i -e s,^root:[^:]*:,root:"`$TOOLS_DIR/usr/bin/mkpasswd -m "sha-512" "$CONFIG_ROOT_PASSWD"`":, $ROOTFS_DIR/etc/shadow
$STEP "Creating the hostname, hosts, resolv.conf"
echo "$CONFIG_HOSTNAME" > $ROOTFS_DIR/etc/hostname
echo "127.0.0.1 localhost" > $ROOTFS_DIR/etc/hosts
echo "127.0.1.1 $CONFIG_HOSTNAME" >> $ROOTFS_DIR/etc/hosts
cat > $ROOTFS_DIR/etc/resolv.conf << "EOF"
# Begin /etc/resolv.conf

nameserver 8.8.8.8
nameserver 8.8.4.4

# End /etc/resolv.conf
EOF
$STEP "Creating the dhcp.eth0, ifconfig.eth0"
cat > $ROOTFS_DIR/etc/dhcp.eth0 << "EOF"
ONBOOT="yes"
IFACE="eth0"
SERVICE="dhcpcd"
DHCP_START="-b -q"
DHCP_STOP="-k"
EOF
cat > $ROOTFS_DIR/etc/ifconfig.eth0 << "EOF"
ONBOOT="yes"
IFACE="eth0"
SERVICE="dhcpcd"
DHCP_START="-b -q"
DHCP_STOP="-k"
EOF
$STEP "Creating the inittab"
cat > $ROOTFS_DIR/etc/inittab << "EOF"
# Begin /etc/inittab

id:3:initdefault:

si::sysinit:/etc/rc.d/init.d/rc S

l0:0:wait:/etc/rc.d/init.d/rc 0
l1:S1:wait:/etc/rc.d/init.d/rc 1
l2:2:wait:/etc/rc.d/init.d/rc 2
l3:3:wait:/etc/rc.d/init.d/rc 3
l4:4:wait:/etc/rc.d/init.d/rc 4
l5:5:wait:/etc/rc.d/init.d/rc 5
l6:6:wait:/etc/rc.d/init.d/rc 6

ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now

su:S016:once:/sbin/sulogin

1:2345:respawn:/sbin/agetty --noclear tty1 9600
2:2345:respawn:/sbin/agetty tty2 9600
3:2345:respawn:/sbin/agetty tty3 9600
4:2345:respawn:/sbin/agetty tty4 9600
5:2345:respawn:/sbin/agetty tty5 9600
6:2345:respawn:/sbin/agetty tty6 9600

# End /etc/inittab
EOF
$STEP "Creating the rc.site"
cat > $ROOTFS_DIR/etc/sysconfig/rc.site << "EOF"
# rc.site
# Optional parameters for boot scripts.

# Distro Information
# These values, if specified here, override the defaults
DISTRO="Linux From Scratch on the ARM" # The distro name
DISTRO_CONTACT="lee@kyuhyuk.kr" # Bug report address
DISTRO_MINI="CLFS-ARM" # Short name used in filenames for distro config

# Define custom colors used in messages printed to the screen

# Please consult `man console_codes` for more information
# under the "ECMA-48 Set Graphics Rendition" section
#
# Warning: when switching from a 8bit to a 9bit font,
# the linux console will reinterpret the bold (1;) to
# the top 256 glyphs of the 9bit font.  This does
# not affect framebuffer consoles

# These values, if specified here, override the defaults
#BRACKET="\\033[1;34m" # Blue
#FAILURE="\\033[1;31m" # Red
#INFO="\\033[1;36m"    # Cyan
#NORMAL="\\033[0;39m"  # Grey
#SUCCESS="\\033[1;32m" # Green
#WARNING="\\033[1;33m" # Yellow

# Use a colored prefix
# These values, if specified here, override the defaults
#BMPREFIX="     "
#SUCCESS_PREFIX="${SUCCESS}  *  ${NORMAL}"
#FAILURE_PREFIX="${FAILURE}*****${NORMAL}"
#WARNING_PREFIX="${WARNING} *** ${NORMAL}"

# Manually seet the right edge of message output (characters)
# Useful when resetting console font during boot to override
# automatic screen width detection
#COLUMNS=120

# Interactive startup
#IPROMPT="yes" # Whether to display the interactive boot prompt
#itime="3"    # The amount of time (in seconds) to display the prompt

# The total length of the distro welcome string, without escape codes
#wlen=$(echo "Welcome to ${DISTRO}" | wc -c )
#welcome_message="Welcome to ${INFO}${DISTRO}${NORMAL}"

# The total length of the interactive string, without escape codes
#ilen=$(echo "Press 'I' to enter interactive startup" | wc -c )
#i_message="Press '${FAILURE}I${NORMAL}' to enter interactive startup"

# Set scripts to skip the file system check on reboot
#FASTBOOT=yes

# Skip reading from the console
HEADLESS=yes

# Write out fsck progress if yes
VERBOSE_FSCK=yes

# Speed up boot without waiting for settle in udev
#OMIT_UDEV_SETTLE=yes

# Speed up boot without waiting for settle in udev_retry
#OMIT_UDEV_RETRY_SETTLE=yes

# Skip cleaning /tmp if yes
#SKIPTMPCLEAN=no

# For setclock
#UTC=1
#CLOCKPARAMS=

# For consolelog (Note that the default, 7=debug, is noisy)
#LOGLEVEL=7

# For network
#HOSTNAME=pilfs

# Delay between TERM and KILL signals at shutdown
#KILLDELAY=3

# Optional sysklogd parameters
#SYSKLOGD_PARMS="-m 0"

# Console parameters
#UNICODE=1
#KEYMAP="de-latin1"
#KEYMAP_CORRECTIONS="euro2"
#FONT="lat0-16 -m 8859-15"
#LEGACY_CHARSET=
EOF
$STEP "Creating the inputrc"
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
$STEP "Creating the shells"
cat > $ROOTFS_DIR/etc/shells << "EOF"
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
EOF
$STEP "Creating the profile"
cat > $ROOTFS_DIR/etc/profile << "EOF"
# Begin /etc/profile
# Written for Beyond Linux From Scratch
# by James Robertson <jameswrobertson@earthlink.net>
# modifications by Dagmar d'Surreal <rivyqntzne@pbzpnfg.arg>

# System wide environment variables and startup programs.

# System wide aliases and functions should go in /etc/bashrc.  Personal
# environment variables and startup programs should go into
# ~/.bash_profile.  Personal aliases and functions should go into
# ~/.bashrc.

# Functions to help us manage paths.  Second argument is the name of the
# path variable to be modified (default: PATH)
pathremove () {
	local IFS=':'
	local NEWPATH
	local DIR
	local PATHVARIABLE=${2:-PATH}
	for DIR in ${!PATHVARIABLE} ; do
		if [ "$DIR" != "$1" ] ; then
		  NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
		fi
	done
	export $PATHVARIABLE="$NEWPATH"
}

pathprepend () {
	pathremove $1 $2
	local PATHVARIABLE=${2:-PATH}
	export $PATHVARIABLE="$1${!PATHVARIABLE:+:${!PATHVARIABLE}}"
}

pathappend () {
	pathremove $1 $2
	local PATHVARIABLE=${2:-PATH}
	export $PATHVARIABLE="${!PATHVARIABLE:+${!PATHVARIABLE}:}$1"
}

export -f pathremove pathprepend pathappend

# Set the initial path
export PATH=/bin:/usr/bin

if [ $EUID -eq 0 ] ; then
	pathappend /sbin:/usr/sbin
	unset HISTFILE
fi

# Setup some environment variables.
export HISTSIZE=1000
export HISTIGNORE="&:[bf]g:exit"

# Set some defaults for graphical systems
export XDG_DATA_DIRS=/usr/share/
export XDG_CONFIG_DIRS=/etc/xdg/

# Setup a red prompt for root and a green one for users.
NORMAL="\[\e[0m\]"
RED="\[\e[1;31m\]"
GREEN="\[\e[1;32m\]"
if [[ $EUID == 0 ]] ; then
	PS1="$RED\u [ $NORMAL\w$RED ]# $NORMAL"
else
	PS1="$GREEN\u [ $NORMAL\w$GREEN ]\$ $NORMAL"
fi

for script in /etc/profile.d/*.sh ; do
	if [ -r $script ] ; then
		. $script
	fi
done

unset script RED GREEN NORMAL

# End /etc/profile
EOF
$STEP "Creating the bashrc"
cat > $ROOTFS_DIR/etc/bashrc << "EOF"
# Begin /etc/bashrc
# Written for Beyond Linux From Scratch
# by James Robertson <jameswrobertson@earthlink.net>
# updated by Bruce Dubbs <bdubbs@linuxfromscratch.org>

# System wide aliases and functions.

# System wide environment variables and startup programs should go into
# /etc/profile.  Personal environment variables and startup programs
# should go into ~/.bash_profile.  Personal aliases and functions should
# go into ~/.bashrc

# Provides colored /bin/ls and /bin/grep commands.  Used in conjunction
# with code in /etc/profile.

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Provides prompt for non-login shells, specifically shells started
# in the X environment. [Review the LFS archive thread titled
# PS1 Environment Variable for a great case study behind this script
# addendum.]

NORMAL="\[\e[0m\]"
RED="\[\e[1;31m\]"
GREEN="\[\e[1;32m\]"
if [[ $EUID == 0 ]] ; then
	PS1="$RED\u [ $NORMAL\w$RED ]# $NORMAL"
else
	PS1="$GREEN\u [ $NORMAL\w$GREEN ]\$ $NORMAL"
fi

unset RED GREEN NORMAL

# End /etc/bashrc
EOF
$STEP "Creating the /etc/profile.d"
mkdir -v $ROOTFS_DIR/etc/profile.d
cat > $ROOTFS_DIR/etc/profile.d/dircolors.sh << "EOF"
# Setup for /bin/ls and /bin/grep to support color, the alias is in /etc/bashrc.
if [ -f "/etc/dircolors" ] ; then
        eval $(dircolors -b /etc/dircolors)
fi

if [ -f "$HOME/.dircolors" ] ; then
        eval $(dircolors -b $HOME/.dircolors)
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'
EOF
cat > $ROOTFS_DIR/etc/profile.d/extrapaths.sh << "EOF"
if [ -d /usr/local/lib/pkgconfig ] ; then
        pathappend /usr/local/lib/pkgconfig PKG_CONFIG_PATH
fi
if [ -d /usr/local/bin ]; then
        pathprepend /usr/local/bin
fi
if [ -d /usr/local/sbin -a $EUID -eq 0 ]; then
        pathprepend /usr/local/sbin
fi

# Set some defaults before other applications add to these paths.
pathappend /usr/share/man  MANPATH
pathappend /usr/share/info INFOPATH
EOF
cat > $ROOTFS_DIR/etc/profile.d/readline.sh << "EOF"
# Setup the INPUTRC environment variable.
if [ -z "$INPUTRC" -a ! -f "$HOME/.inputrc" ] ; then
        INPUTRC=/etc/inputrc
fi
export INPUTRC
EOF
cat > $ROOTFS_DIR/etc/profile.d/umask.sh << "EOF"
# By default, the umask should be set.
if [ "$(id -gn)" = "$(id -un)" -a $EUID -gt 99 ] ; then
  umask 002
else
  umask 022
fi
EOF
cat > $ROOTFS_DIR/etc/profile.d/i18n.sh << "EOF"
# Set up i18n variables
export LANG=en_US.UTF-8
EOF

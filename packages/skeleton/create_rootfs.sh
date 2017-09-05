#!/bin/bash
$STEP "Create root file system directory."
mkdir -pv $ROOTFS_DIR/{dev,proc,sys,run}
mkdir -pv $ROOTFS_DIR/{bin,boot,etc/{opt,sysconfig},home,lib/firmware,mnt,opt}
mkdir -pv $ROOTFS_DIR/home/clfs
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
clfs:x:1000:1000::/home/clfs:/bin/bash
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
clfs:!:1000:
EOF
cat > $ROOTFS_DIR/etc/shadow << "EOF"
root::10933:0:99999:7:::
daemon:*:10933:0:99999:7:::
bin:*:10933:0:99999:7:::
sys:*:10933:0:99999:7:::
sync:*:10933:0:99999:7:::
mail:*:10933:0:99999:7:::
www-data:*:10933:0:99999:7:::
operator:*:10933:0:99999:7:::
nobody:*:10933:0:99999:7:::
dbus:*:::::::
systemd-bus-proxy:*:::::::
systemd-journal-gateway:*:::::::
systemd-journal-remote:*:::::::
systemd-journal-upload:*:::::::
systemd-network:*:::::::
systemd-resolve:*:::::::
systemd-timesync:*:::::::
clfs:$6$4RrK1qQRb4TL5yar$6X3UoofCf32P9cmbdprzkpjwsZ5ZS7sD54twEeHmVwDZAnjFdwZfpPvAmMp2ozcexbmWhFFE.ICyDLcqfGwcK/:17414:0:99999:7:::
EOF
sed -i -e s,^root:[^:]*:,root:"`$TOOLS_DIR/bin/mkpasswd -m "sha-512" "$CONFIG_ROOT_PASSWD"`":, $ROOTFS_DIR/etc/shadow
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

mkdir -pv $ROOTFS_DIR/etc/network/{if-down.d,if-post-down.d,if-pre-up.d,if-up.d}

cat > $ROOTFS_DIR/etc/network/if-pre-up.d/wait_iface << "EOF"
#!/bin/sh

# In case we have a slow-to-appear interface (e.g. eth-over-USB),
# and we need to configure it, wait until it appears, but not too
# long either. IF_WAIT_DELAY is in seconds.

if [ "${IF_WAIT_DELAY}" -a ! -e "/sys/class/net/${IFACE}" ]; then
    printf "Waiting for interface %s to appear" "${IFACE}"
    while [ ${IF_WAIT_DELAY} -gt 0 ]; do
        if [ -e "/sys/class/net/${IFACE}" ]; then
            printf "\n"
            exit 0
        fi
        sleep 1
        printf "."
        : $((IF_WAIT_DELAY -= 1))
    done
    printf " timeout!\n"
    exit 1
fi
EOF
chmod 755 $ROOTFS_DIR/etc/network/if-pre-up.d/wait_iface

cat > $ROOTFS_DIR/etc/network/interfaces << "EOF"
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
  wait-delay 15
EOF

$STEP "The Bash Shell Startup Files"

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
export XDG_RUNTIME_DIR=/tmp/xdg-$USER

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

install --directory --mode=0755 $ROOTFS_DIR/etc/profile.d

cat > $ROOTFS_DIR/etc/profile.d/bash_completion.sh << "EOF"
# Begin /etc/profile.d/bash_completion.sh
# Import bash completion scripts

for script in /etc/bash_completion.d/*.sh ; do
        if [ -r $script ] ; then
                . $script
        fi
done
# End /etc/profile.d/bash_completion.sh
EOF

install --directory --mode=0755 $ROOTFS_DIR/etc/bash_completion.d

cat > $ROOTFS_DIR/etc/profile.d/dircolors.sh << "EOF"
# Setup for /bin/ls and /bin/grep to support color, the alias is in /etc/bashrc.
if [ -f "/etc/dircolors" ] ; then
        eval $(dircolors -b /etc/dircolors)
fi

if [ -f "$HOME/.dircolors" ] ; then
        eval $(dircolors -b $HOME/.dircolors)
fi

alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -la --color=auto'
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
alias ll='ls -l --color=auto'
alias la='ls -la --color=auto'
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

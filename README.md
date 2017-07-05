# Cross Linux From Scratch (CLFS) on the ARM architecture

Cross Linux From Scratch (CLFS) is a project that provides you with step-by-step instructions for building your own customized Linux system entirely from source.

![Screenshot](https://raw.github.com/LeeKyuHyuk/CLFS-ARM/master/screenshot.png)

**Default root password:** `clfs`

### Preparing Build Environment

Debian 9 or Ubuntu 16.04 is recommended.

``` bash
sudo apt update
sudo apt install g++ texinfo gperf qemu-system
```

### Build CLFS-ARM

Download the source code by doing `make download`.

``` bash
make download
make all
```

### Build Toolchain

``` bash
make toolchain
```

```
$ arm-linux-gnueabihf-gcc --version
arm-linux-gnueabihf-gcc (CLFS ARM 2017.07) 6.3.0
Copyright (C) 2016 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

### Build System

``` bash
make system
```

### Build Kernel

``` bash
make kernel
```

### Generate CLFS-ARM root file system image

``` bash
make image
```

### Emulate CLFS-ARM using QEMU

``` bash
make run
```

### Show build settings
``` bash
make settings
```

```
>> Build Settings:
SHELL: bash
CONFIG_HOST: x86_64-cross-linux-gnu
CONFIG_TARGET: arm-linux-gnueabihf
CONFIG_HOSTNAME: clfs-arm
CONFIG_ROOT_PASSWD: clfs
CONFIG_LOCAL_TIMEZONE: Asia/Seoul
CONFIG_PKG_VERSION: CLFS ARM 2017.07
CONFIG_BUG_URL: https://github.com/LeeKyuHyuk/CLFS-ARM/issues
CONFIG_PARALLEL_JOBS: 4
WORKSPACE_DIR: /home/leekyuhyuk/clfs-arm
CONFIG_DIR: /home/leekyuhyuk/clfs-arm/config
DEVICE_DIR: /home/leekyuhyuk/clfs-arm/device
PACKAGES_DIR: /home/leekyuhyuk/clfs-arm/packages
SOURCES_DIR: /home/leekyuhyuk/clfs-arm/sources
SCRIPTS_DIR: /home/leekyuhyuk/clfs-arm/scripts
OUTPUT_DIR: /home/leekyuhyuk/clfs-arm/out
BUILD_DIR: /home/leekyuhyuk/clfs-arm/out/build
TOOLS_DIR: /home/leekyuhyuk/clfs-arm/out/tools
KERNEL_DIR: /home/leekyuhyuk/clfs-arm/out/kernel
ROOTFS_DIR: /home/leekyuhyuk/clfs-arm/out/rootfs
IMAGES_DIR: /home/leekyuhyuk/clfs-arm/out/images
SYSROOT_DIR: /home/leekyuhyuk/clfs-arm/out/tools/usr/arm-linux-gnueabihf/sysroot
PATH: "/home/leekyuhyuk/clfs-arm/out/tools/bin:/home/leekyuhyuk/clfs-arm/out/tools/sbin:/home/leekyuhyuk/clfs-arm/out/tools/usr/bin:/home/leekyuhyuk/clfs-arm/out/tools/usr/sbin:/sbin:/usr/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"

>> Device Settings:
CONFIG_NAME: raspberrypi2
CONFIG_ABI: aapcs-linux
CONFIG_CPU: cortex-a7
CONFIG_FPU: neon-vfpv4
CONFIG_FLOAT: hard
CONFIG_MODE: arm
CONFIG_LINUX_KERNEL_SOURCE: be2540e540f5442d7b372208787fb64100af0c54.tar.gz
CONFIG_LINUX_KERNEL_SOURCE_URL: https://github.com/raspberrypi/linux/archive/be2540e540f5442d7b372208787fb64100af0c54.tar.gz
```

### Built With

- autoconf 2.69
- automake 1.15
- bash 4.4
- bc 1.06.95
- binutils 2.28
- bison 3.0.4
- bzip2 1.0.6
- coreutils 8.27
- diffutils 3.5
- e2fsprogs 1.43.4
- eudev 3.2.1
- file 5.30
- findutils 4.6.0
- flex 2.6.4
- gawk 4.1.4
- gcc 6.3.0
- gdbm 1.13
- gettext 0.19.8.1
- glib 2.52.0
- glibc 2.25
- gmp 6.1.2
- gperf 3.0.4
- grep 3.0
- gzip 1.8
- iana-etc 2.30
- inetutils 1.9.4
- iproute2 4.10.0
- kbd 2.0.4
- kmod 24
- less 487
- libcap 2.25
- libffi 3.2.1
- libpipeline 1.4.1
- libtool 2.4.6
- linux 4.11.7
- m4 1.4.18
- make 4.2.1
- man-pages 4.10
- mpc 1.0.3
- mpfr 3.1.5
- ncurses 6.0
- ntp 4.2.8p9
- openssh 7.4p1
- openssl 1.0.2k
- patch 2.7.5
- pcre 8.40
- pkg-config 0.29.2
- procps-ng 3.3.12
- psmisc 22.21
- readline 7.0
- sed 4.4
- shadow 4.4
- sysklogd 1.5.1
- sysvinit 2.88dsf
- tar 1.29
- texinfo 6.3
- tzdata2017b
- util-linux 2.29.2
- vim 8.0.069
- xz 5.2.3
- zlib 1.2.11

### Thanks to

- [Linux From Scratch](http://www.linuxfromscratch.org/lfs/view/development/)
- [Cross Linux From Scratch (CLFS)](http://clfs.org/)
- [PiLFS](http://www.intestinate.com/pilfs/)
- [Buildroot](https://buildroot.org/)

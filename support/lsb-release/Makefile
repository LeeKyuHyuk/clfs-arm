# 
# Makefile for lsb_release program
#
# Copyright (C) 2000 Free Software Group, Inc
# 
# Christopher Yeoh <cyeoh@linuxcare.com>
#
# This is $Revision: 1.5 $

# Config
prefix=/usr/local
mandir=${prefix}/man

all: man

man: lsb_release.1.gz

lsb_release.1.gz: lsb_release
	@./help2man -N --include ./lsb_release.examples --alt_version_key=program_version ./lsb_release >lsb_release.1
	@gzip -9f lsb_release.1

install: all
	install -D -m 644 lsb_release.1.gz ${mandir}/man1/lsb_release.1.gz
	install -D -m 755 lsb_release ${prefix}/bin/lsb_release

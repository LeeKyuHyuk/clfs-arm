#!/bin/bash
case $1 in
  *.tgz) tar -zxf $1 -C $2 ;;
  *.tar.gz) tar -zxf $1 -C $2 ;;
  *.tar.bz2) tar -jxf $1 -C $2 ;;
  *.tar.xz) tar -Jxf $1 -C $2 ;;
esac

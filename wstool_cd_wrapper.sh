#!/bin/sh


wstool () {
  case "$1" in
    (cd)
      shift; wstool_cd $@
      ;;
    (*)
      command wstool $@
      ;;
  esac
}
#!/bin/sh

wstool_cd () {
  local dest
  if [ "$1" = "" ]; then
    dest=$(wstool info --managed-only --data-only | sed -n '1p' | awk '{print $2}')
    cd $dest
  else
    dest=$(wstool info --managed-only --only=localname,path | awk 'BEGIN {FS=","} {if ($1 == "'"$1"'") print $2}')
    if [ "$dest" = "" ]; then
      echo "$1 not found"
    else
      cd $dest
    fi
  fi
}
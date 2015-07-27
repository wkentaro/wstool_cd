#!/bin/sh

wstool_cd () {
  local dest
  # check if in workspace
  if ! wstool set >/dev/null 2>&1; then
    echo 'not in workspace'
    return 1
  fi
  # execute commands
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
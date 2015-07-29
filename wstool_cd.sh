#!/bin/sh


_wstool_cd_get_workspace () {
  python -c "\
import os
import wstool.common
from wstool.cli_common import get_workspace
try:
    ws=get_workspace(argv=[], shell_path=os.getcwd(),
                     config_filename='.rosinstall')
    print(ws)
except wstool.common.MultiProjectException:
    pass
"
}


wstool_cd () {
  local dest
  local ws_root
  # check if wstool installed
  which wstool >/dev/null 2>&1 || {
    echo "please install wstool"
    echo "run \`pip install wstool\`"
    return 1
  }
  # check if in workspace
  ws_root=$(_wstool_cd_get_workspace)
  [ "$ws_root" = "" ] && {
    echo 'not in workspace'
    return 1
  }
  # execute commands
  if [ "$1" = "" ]; then
    cd $ws_root
  else
    dest=$(wstool info $1 2>&1 | grep '^Path' | awk '{print $2}')
    if [ "$dest" = "" ]; then
      echo "$1 not found"
    else
      cd $dest
    fi
  fi
}
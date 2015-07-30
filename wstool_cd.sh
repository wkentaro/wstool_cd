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
" 2>/dev/null
}


wstool_cd () {
  local localname dest ws_root
  localname=$1
  # check if in workspace
  ws_root=$(_wstool_cd_get_workspace)
  [ "$ws_root" = "" ] && {
    echo 'not in workspace' >&2
    return 1
  }
  # execute commands
  if [ "$localname" = "" ]; then
    cd $ws_root
  else
    dest=$(wstool info $localname 2>&1 | grep '^Path' | awk '{print $2}')
    if [ "$dest" = "" ]; then
      echo "$localname not found" >&2
    elif [ ! -d "$dest" ]; then
      echo "the repo '$localname' path '$dest' not exist" >&2
      echo "need \`wstool update $localname\`?" >&2
    else
      cd $dest
    fi
  fi
}
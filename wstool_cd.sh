#!/bin/sh


_wstool_cd_get_workspace () {
  local ws_root
  ws_root=$(python -c "\
import os
import wstool.common
from wstool.cli_common import get_workspace
try:
    ws = get_workspace(argv=[], shell_path=os.getcwd(),
                       config_filename='.rosinstall')
    print(ws)
except wstool.common.MultiProjectException:
    pass
" 2>/dev/null)
  # you can set WSTOOL_DEFAULT_WS in your shell
  if [ "$ws_root" = "" ]; then
    if [ "$WSTOOL_DEFAULT_WORKSPACE" = "" ]; then
      echo 'not in workspace' >&2
      return 1
    fi
    ws_root=$WSTOOL_DEFAULT_WORKSPACE
  fi
  echo $ws_root
}


wstool_cd () {
  local localname dest ws_root
  localname=$1
  # check if in workspace
  ws_root=$(_wstool_cd_get_workspace)
  # execute commands
  if [ "$localname" = "" ]; then
    cd $ws_root
  else
    dest=$(wstool info $localname -t $ws_root 2>&1 | grep '^Path' | awk '{print $2}')
    if [ "$dest" = "" ]; then
      echo "$localname not found" >&2
    elif [ ! -d "$dest" ]; then
      echo "path '$dest' for '$localname' not exist" >&2
      echo "need \`wstool update $localname\`?" >&2
    else
      cd $dest
    fi
  fi
}
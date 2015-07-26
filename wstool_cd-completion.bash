#!/usr/bin/env bash

_wstool_cd ()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=""

    if [[ ${opts} = "" ]] ; then
        opts=$(wstool info --only=localname)
    fi

    if [[ ${cur} = * ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
        return 0
    fi
}

complete -F _wscd wscd
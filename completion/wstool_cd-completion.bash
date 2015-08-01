# ZSH support
if [[ -n ${ZSH_VERSION-} ]]; then
    autoload -U +X bashcompinit && bashcompinit
fi

_wstool_cd ()
{
    local ws_root
    # check if in workspace
    ws_root=$(_wstool_cd_get_workspace 2>/dev/null)
    [ "$ws_root" = "" ] && return 1

    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=""

    if [[ ${opts} = "" ]] ; then
        opts=$(wstool info -t $ws_root --only=localname)
    fi

    if [[ ${cur} = * ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
        return 0
    fi
}

complete -F _wstool_cd wstool_cd

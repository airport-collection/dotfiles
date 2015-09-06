# vim: filetype=zsh sw=2 ts=2 sts=2 et tw=80 foldlevel=0 nospell

init::sourced ${0:a} && return

function strings::strip_slash() {
  [[ $1 =~ .*/$ ]] && echo ${1%/}
}

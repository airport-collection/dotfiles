#!/usr/bin/env zsh

fpath+=(${0:h}/../../lib/)
autoload -Uz -- ${0:h}/../../lib/[^_]*(:t)

set -x

function test::shell::eval() {
  local _cmd _expected _actual
  _cmd='echo "hello world"'

  _expected='hello world'
  _actual="$(shell::eval ${_cmd})"
  [[ "${_expected}" == "${_actual}" ]]

  mode::toggle-dryrun
  _expected=$(printf "%-${PREFIXWIDTH}s echo \"hello world\"" '[Dryrun]')
  _actual="$(shell::eval ${_cmd})"
  [[ "${_expected}" == "${_actual}" ]]
}
test::shell::eval

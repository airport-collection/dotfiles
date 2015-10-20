#!/usr/bin/env zsh

fpath+=(${0:h}/../../lib/)
autoload -Uz -- ${0:h}/../../lib/[^_]*(:t)

set -x

function test::mode::verbose() {
  mode::set-verbose 1
  mode::verbose 0
  [[ $? -eq 0 ]]
  mode::verbose 2
  [[ $? -eq 1 ]]
}
test::mode::verbose

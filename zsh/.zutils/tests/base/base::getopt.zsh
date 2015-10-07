#!/usr/bin/env zsh

source "${0:h}/../../lib/init.zsh"
source "${0:h}/../../lib/base.zsh"

set -x

function test::base::getopt() {
  local -A _fn_options
  base::getopt df:u: no-detached,foo:,unset: --no-detached -f yo
  [[ ${_fn_options[--no-detached]} == "true" ]]
  [[ ${_fn_options[--foo]} == "yo" ]]
  [[ ${_fn_options[--unset]} == "" ]]
}
test::base::getopt

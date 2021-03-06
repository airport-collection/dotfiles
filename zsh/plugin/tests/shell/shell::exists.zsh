#!/usr/bin/env zsh

fpath+=(${0:h}/../../functions/)
autoload -Uz -- ${0:h}/../../functions/[^_]*(:t)

set -x

function test::shell::exists() {
  shell::exists --sub test::_foo_
  [[ $? -eq 1 ]]
  function test::_foo_() {
    ;
  }
  shell::exists -s test::_foo_
  [[ $? -eq 0 ]]

  shell::exists --var __TEST_FOO__
  [[ $? -eq 1 ]]
  declare __TEST_FOO__
  shell::exists --var __TEST_FOO__
  [[ $? -eq 0 ]]
}
test::shell::exists

# vim: set sw=2 ts=2 sts=2 et tw=78 foldlevel=0 foldmethod=marker filetype=sh nospell:

source ${__MYZSHLIB__}/base.zsh
source ${__MYZSHLIB__}/io.zsh

base::should_source ${0:a} $__GIT__ || return
__GIT__=$(base::script_signature ${0:a})

# Check subdirs of current directory, and report repos that are dirty
function git::check_dirty_repos() {
  local -a dirty_repos
  dirty_repose=()
  for dir in */; do
    io::msg "Checking " ${dir}
    pushd ${dir}
    git dirty
    if [[ $? -ne 0 ]]; then
      dirty_repos+=${dir}
    fi
    popd
  done

  if [[ ${#dirty_repos} -gt 0 ]]; then
    io::err "Dirty repos found!"
    for dir in ${dirty_repos}; do
      io::err "Repo: ${dir}"
    done
  fi
}

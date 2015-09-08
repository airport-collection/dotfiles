# vim: filetype=zsh sw=2 ts=2 sts=2 et tw=80 foldlevel=0 nospell

: <<=cut
=pod

=head1 NAME

File: base.zsh -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head2 Methods

=over 4
=cut

init::sourced "${0:a}" && return
# Public: Source a library file automatically if file modified since last
# source.
#
# In zsh we can get the script name with ${0:a}, it would contain the function
# name if this is used within a function.
# Source: zshexpn(1) man page, section HISTORY EXPANSION, subsection Modifiers
# (or simply info -f zsh -n Modifiers)
# More portable way to get this:
# canonical=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)/$(basename -- "$0")")

# Check whether something 'exists'
# The check order is the following:
# 1. Variable or Function
# 2. Binary
# 3. File or Directory
#
# $1 The thing to be checked whether it exists.
#
# Examples
#   base::exists "VAR"
#
# Returns the exist code to indicator the existence.
function base::exists() {
  eval "[[ -n \${$1+1} ]]" && return 0
  whence "$1" > /dev/null && return 0
  [[ -e "$1" || -d "$1" ]] && return 0
  return 1
}

: <<=cut
=back
=cut

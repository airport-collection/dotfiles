# vim: filetype=zsh sw=2 ts=2 sts=2 et tw=80 foldlevel=0 nospell

: <<=cut
=pod

=head1 NAME

File: functions.zsh - My autoload functions.

=head1 DESCRIPTION

=head2 Methods

=over 4
=cut

# zsh options {{{
# Options are not ordered alphabetically, but their order in zsh man page
# Changing Directories
setopt AUTOCD                                                                  # Switching directories for lazy people
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
setopt PUSHD_SILENT

# Completion
setopt ALWAYS_TO_END                                                            # When complete from middle, move cursor
setopt AUTO_LIST
setopt AUTO_MENU                                                                # Automatically use menu completion after the second consecutive request for completion
setopt AUTO_PARAM_KEYS
setopt AUTO_PARAM_SLASH
setopt AUTO_REMOVE_SLASH
setopt COMPLETE_ALIASES                                                         # Prevent aliases from being internally substituted before completion is attempted
setopt COMPLETE_IN_WORD                                                         # Not just at the end
setopt GLOB_COMPLETE
setopt LIST_AMBIGUOUS
setopt LIST_TYPES
setopt MENU_COMPLETE

# Expansion and Globbing
setopt BAD_PATTERN
setopt CASEMATCH                                                                # Whether the regex comparison (e.g. =~) will match case
setopt EXTENDED_GLOB                                                            # Weird &amp; wacky pattern matching - yay zsh!
setopt GLOB
setopt MARK_DIRS
setopt NO_NOMATCH                                                               # pass through '*' if globbing fails
setopt WARN_CREATE_GLOBAL

# History
setopt APPEND_HISTORY
setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt HIST_ALLOW_CLOBBER
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FCNTL_LOCK
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS                                                     # Do not enter command lines into the history list if they are duplicates of the previous event
setopt HIST_IGNORE_DUPS                                                         # ignore duplication command history list
setopt HIST_IGNORE_SPACE                                                        # Remove command lines from the history list when the first character on the line is a space
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS                                                       # Remove superfluous blanks from each command line being added to the history list
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY                                                              # When using ! cmds, confirm first
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY                                                            # share command history data

# Input/Output
setopt ALIASES
setopt CLOBBER
setopt CORRECT
setopt NO_FLOW_CONTROL
setopt INTERACTIVE_COMMENTS                                                     # Escape commands so I can use them later
setopt PRINT_EXIT_VALUE                                                         # Alert me if something's failed
setopt RC_QUOTES
setopt SHORT_LOOPS

# Job Control
setopt CHECK_JOBS
setopt NOHUP                                                                    # Don't kill background jobs when I logout
setopt LONG_LIST_JOBS
setopt MONITOR

# Prompting
setopt PROMPT_BANG
setopt PROMPT_CR                                                             # Default on, resulting in a carriage return ^M when enter on the numeric pad is pressed.
setopt PROMPT_PERCENT
setopt PROMPT_SUBST

# Scripts and Functions
setopt C_BASES
setopt ERR_RETURN
setopt LOCAL_OPTIONS                                                            # Allow setting function local options with 'setopt localoptions foo nobar'
setopt FUNCTION_ARGZERO
# setopt SOURCE_TRACE
# setopt XTRACE

# Shell Emulation
setopt NO_CONTINUE_ON_ERROR
setopt KSH_ARRAYS                                                               # Make array index starts at 0
setopt RC_EXPAND_PARAM

# Zle
setopt VI                                                                       # Use vi key bindings in ZSH (bindkey -v)
# }}}
# aliases {{{
case $HIST_STAMPS in
  'mm/dd/yyyy') alias history='fc -fl 1' ;;
  'dd.mm.yyyy') alias history='fc -El 1' ;;
  'yyyy-mm-dd') alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

alias date="\\${CMDPREFIX}date"
alias grepc='\grep -C 5 '
alias info='\info --vi-keys'
alias mank='\man -K'
alias mktemp="${CMDPREFIX}mktemp"
alias nvim='NVIM=nvim nvim'
alias stat="${CMDPREFIX}stat"
alias stow='\stow -v'
alias tl='\tmux list-sessions'
alias tmux='TERM=screen-256color \tmux -2'
alias unbindkey='bindkey -r'
alias vartype='declare -p'
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
[[ "$+aliases[run-help]" == "1" ]] && unalias run-help                                   # Use built-in run-help to use online help
autoload run-help                                                               # Use the zsh built-in run-help function, run-help is aliased to man by default
# }}}
# key bindings {{{
zle -N up-line-or-beginning-search
autoload -Uz up-line-or-beginning-search                                        # Put cursor at end of line when using Up for command history
zle -N down-line-or-beginning-search
autoload -Uz down-line-or-beginning-search                                      # Put cursor at end of line when using Down for command history

# TODO(me): Bind C-Left and C-Right as HOME / END
bindkey '^[OD' beginning-of-line                                                # Set left arrow as HOME
bindkey '^[OC' end-of-line                                                      # Set right arrow as END
bindkey -s 'OM' ''                                                          # Let enter in numeric keypad work as newline (return)
bindkey -r '^S'                                                                 # By default <C-S> is bind to self-insert, which presents vim from getting the combination.
bindkey '^R' history-incremental-pattern-search-backward                        # Search history backward incrementally
bindkey '^[[A' up-line-or-beginning-search                                      # Up
bindkey '^[[B' down-line-or-beginning-search                                    # Down
# bindkey '^I' expand-or-complete-prefix
# bindkey '^[[3~' delete-char
bindkey '\C-n' menu-complete
bindkey '\C-p' reverse-menu-complete
# }}}
# colors utils {{{
[[ -f ~/.dircolors-solarized/dircolors.256dark ]] && \
  eval "$(${CMDPREFIX}dircolors $HOME/.dircolors-solarized/dircolors.256dark)"

: <<=cut
=item Function C<colors::define>

Define color env variables.

@return NULL
=cut
autoload -Uz colors::define && colors::define

: <<=cut
=item Function C<colors::manpage>

Make man page colorful.

@return NULL
=cut
autoload -Uz colors::manpage && colors::manpage
# }}}
# file utils {{{
: <<=cut
=item Function C<file::find-ignore-dir>

Find in current directory, with dir $1 ignored.
TODO: Make $1 an array, and ignore a list of dirs.

$1 The directory to ignore.

@return NULL
=cut
autoload -Uz file::find-ignore-dir

: <<=cut
=item Function C<file::find-ignore-git>

Find in current directory, with dir .git ignored.
A shortcut for file::find-ignore-dir for git.

@return NULL
=cut
autoload -Uz file::find-ignore-git

: <<=cut
=item Function C<file::rm>

Use trash to remove files so it can be recovered!
Accepts rm arguments to be compatible wit rm.
Usually we define alias for it.

Examples
  source file.zsh
  alias rm=file::rm

Arguments
  Same as rm

@return NULL
=cut
autoload -Uz file::rm

: <<=cut
=item Function C<file::ls>

List files in long format.

@return NULL
=cut
autoload -Uz file::ls

alias la='file::ls -a'
alias ll='file::ls -l'
alias lla='file::ls -la'
alias ls='file::ls'
alias rm='file::rm'
# }}}
# git utils {{{
export GIT_EDITOR='vim'

: <<=cut
=item Function C<git::check-dirty-repos>

Check subdirs of current directory, and report repos that are dirty
Number of arguments accepted: --no-detached

@return NULLPTR
=cut
autoload -Uz git::check-dirty-repos

: <<=cut
=item Function C<git::has-branch>

Whether a branch exists in current depo.

@return 0 if exists, 1 otherwise.
=cut
autoload -Uz git::has-branch

: <<=cut
=item Function C<git::parent-branch>

# Get parent branch of a branch, defaults to current branch.
# How it works:
# 1| Display a textual history of all commits.
# 2| Ancestors of the current commit are indicated
#    by a star. Filter out everything else.
# 3| Ignore all the commits in the current branch.
# 4| The first result will be the nearest ancestor branch.
#    Ignore the other results.
# 5| Branch names are displayed [in brackets]. Ignore
#    everything outside the brackets, and the brackets.
# 6| Sometimes the branch name will include a ~2 or ^1 to
#    indicate how many commits are between the referenced
#    commit and the branch tip. We don't care. Ignore them.

@return NULL
=cut
autoload -Uz git::parent-branch

: <<=cut
=item Function C<git::new-workdir>

Create a new git working dir based on existing repo, and create a new branch in
the new workign dir.

$1 Source git working directory
$2 New git working directory
$3 New branch name

@return NULL
=cut
autoload -Uz git::new-workdir

: <<=cut
=item Function C<git::submodule-url>

List of url of all submodules.

@return NULL
=cut
autoload -Uz git::submodule-url

: <<=cut
=item Function C<git::submodule-mv>

Move submodule with a single command.

@return NULL
=cut
autoload -Uz git::submodule-mv
# }}}
# misc utils {{{
declare -a __TMUX_VARS__
__TMUX_VARS__=(SSH_CLIENT SSH_OS)

: <<=cut
=item Function C<util::geoinfo>

Get the geo location information.

@return list of values for requested fields.
=cut
autoload -Uz util::geoinfo

: <<=cut
=item Function C<util::start-ssh-agent>

Start ssh agent if not yet.

@return NULL
=cut
autoload -Uz util::start-ssh-agent

: <<=cut
=item Function C<util::ta>

Tmux attach wrapper, which updates tmux environment as configured.

@return NULL
=cut
autoload -Uz util::ta

: <<=cut
=item Function C<util::histgrep>

Grep in reverse order in history.

@return NULL
=cut
autoload -Uz util::histgrep

: <<=cut
=item Function C<util::setup-abbrevs>

Setup zsh abbreviations.

@return NULL
=cut
autoload -Uz util::setup-abbrevs

: <<=cut
=item Function C<util::vim>

Open files with vim in a single vim instance in one tmux window.

@return NULL
=cut
autoload -Uz util::vim

: <<=cut
=item Function C<util::gvim>

Open files with gvim in a single gvim instance.

@return NULL
=cut
autoload -Uz util::gvim

: <<=cut
=item Function C<util::check-test-coverage>

Check test coverage for zsh functions.

@return NULL
=cut
autoload -Uz util::check-test-coverage

autoload -Uz util::tmux-attach

autoload -Uz util::powerline-shell

autoload -Uz util::copy-tmux-vars

autoload -Uz util::install-precmd

autoload -Uz util::fix-display

autoload -Uz util::run

autoload -Uz zsh-startup-profiling

alias ta='util::ta'
alias ts='util::tmux_start'
alias vi='util::vim'                                                          # alias vi='vi -p'
alias vim='util::vim'                                                         # alias vim='vim -p'
alias run='util::run'

util::install-precmd
util::setup-abbrevs
util::fix-display
util::start-ssh-agent "${SSH_AGENT_NAME}"
# }}}
# net utils {{{
: <<=cut
=item Function C<net::external-ip>

Get the external ip address for current host.

@return string of external ip address.
=cut
autoload -Uz net::external-ip

: <<=cut
=item Function C<net::ssh>

Utility function that set some env variables by default when connected through ssh.
Arguments will be passed through to ssh

@return NULL
=cut
autoload -Uz net::ssh

: <<=cut
=item Function C<net::port-open>

Test whether a port / range of ports is / are open.

$1 Host address
$2 Port number

Example:
  net::port_open 127.0.0.1 80
  net::port_open 127.0.0.1 80 90
  net::port_open 127.0.0.1 80-90

@return 0 if the port is open on specified host, 1 otherwise.
=cut
autoload -Uz net::port-open

alias ssh='net::ssh'
# }}}

: <<=cut
=back
=cut

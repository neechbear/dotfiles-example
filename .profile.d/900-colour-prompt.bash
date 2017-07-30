
# Set aliases if we're running interactively
if [[ "$-" = *"i"* ]] ; then
  if [ -z "$COLOUR_TERMINAL" ] ; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null ; then
      export COLOUR_TERMINAL=yes
    else
      unset COLOUR_TERMINAL
    fi
  fi

  if typeset -F __upower_prompt >/dev/null 2>&1 ; then
    KVM_CONFIG="${KVM_CONFIG:+$KVM_CONFIG:}"$'$(__upower_prompt)'
  fi

  if [ -n "$COLOUR_TERMINAL" ] ; then
    PS1="\[\e[0;32m]\u\[\e[1m\]@\[\e[0;32m\]\h\[\e[0m\]"$'$(__upower_prompt)'":\w"

    # oh-my-git
    __ohmygit=1
    __ohmygit="$(git config --local --get oh-my-git.enabled 2>/dev/null)"
    __omgrc=$?
    if [[ -r ~/.oh-my-git/prompt.sh \
        && -z "${VSCODE_PID:-}" \
        && $__omgrc -le 1 \
        && ! "$__ohmygit" =~ [Ff]alse ]] \
        && type -P git >/dev/null 2>&1 ; then
      PS1+=' \$ '
      VIRTUAL_ENV_DISABLE_PROMPT=true
      function omg_prompt_callback() {
        if [ -n "${VIRTUAL_ENV}" ]; then
          echo "\e[0;31m(`basename ${VIRTUAL_ENV}`)\e[0m "
        fi
      }
      : ${omg_has_untracked_files_symbol:=''}
      source ~/.oh-my-git/prompt.sh
      function omg () {
        for var in $(compgen -v omg_ | grep _symbol$) ; do
          echo -e "${!var}\t$var"
        done
      }

    # bundled standard git-sh-prompt
    elif [[ -r /usr/lib/git-core/git-sh-prompt ]] ; then
      source /usr/lib/git-core/git-sh-prompt
      export GIT_PS1_SHOWDIRTYSTATE=1
      PS1+='$(__git_ps1 " (%s)")\$ '

    # no git prompt
    else
      PS1+=' \$ '
    fi
    export PS1
    unset __ohmygit
    unset __omgrc
  fi
fi


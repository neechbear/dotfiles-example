# ~/.bash_logout: executed by bash(1) when login shell exits.

# When an ssh-agent is active, kill it if this is your only login.
if [[ -n "$SSH_AGENT_PID" ]] && [[ -x /usr/bin/who ]] && \
   [[ -x /usr/bin/ssh-agent ]] ;  then
    TTY="${TTY:-$(/usr/bin/tty)}"
    _killagent=1
    while read -r _user _tty _ ; do
       if [[ "$_user" = "$USER" && ! "$_tty" = "${TTY#/dev/}" ]] ; then
           unset _killagent
           break
       fi
    done < <(/usr/bin/who)
    if [[ -n "${_killagent:-}" ]] ; then
      eval $(/usr/bin/ssh-agent -k)
    fi
fi

# When leaving the console, clear the screen to increase privacy.
if [[ "$SHLVL" = 1 ]] ; then
    [[ -x /usr/bin/clear_console ]] && /usr/bin/clear_console -q
fi

# Invalidate the gpm selection buffer if logging out from a virtual terminal.
if [[ -x /sbin/consoletype ]] && /sbin/consoletype fg ; then
    if [[ -r /var/run/gpm.pid && -d "/proc/$(/bin/cat /var/run/gpm.pid)" ]]
    then
        kill -USR2 "$(</var/run/gpm.pid)"
    fi
fi
 
clear


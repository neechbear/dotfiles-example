
if [ -n "$SSH_AUTH_SOCK" ] && [ -e "$SSH_AUTH_SOCK" ] ; then
  # Use forwarded agent.
  /usr/bin/ssh-add -l

# Start an ssh-agent if one isn't running already.
elif ! [ -e ~/.ssh/no-agent ] && [ -x /usr/bin/ssh-add ] && \
       [ -z "$SSH_AGENT_PID" ] && [ -x /usr/bin/ssh-agent ] && \
       [ -x /usr/bin/pgrep ] && [ -x /usr/bin/find ] ; then
  if SSH_AGENT_PID="$(/usr/bin/pgrep -n -u "$USER" ssh-agent)" ; then
    # Reuse existing agent.
    export SSH_AGENT_PID
    export SSH_AUTH_SOCK="$(/usr/bin/find /tmp/ -mindepth 2 -maxdepth 2 -type s -name "agent.$(( SSH_AGENT_PID - 1 ))" 2>/dev/null)"
    /usr/bin/ssh-add -l
  else
    # Start new agent.
    eval $(/usr/bin/ssh-agent -t 7200)
  fi
fi


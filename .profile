# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# The default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# /bin/bash
#        The bash executable
# /etc/profile
#        The systemwide initialization file, executed for login shells
# /etc/bash.bashrc
#        The systemwide per-interactive-shell startup file
# /etc/bash.bash.logout
#        The systemwide login shell cleanup file, executed when a login shell exits
# ~/.bash_profile
#        The personal initialization file, executed for login shells
# ~/.bashrc
#        The individual per-interactive-shell startup file
# ~/.bash_logout
#        The individual login shell cleanup file, executed when a login shell exits
# ~/.inputrc
#        Individual readline initialization file

if [ -n "$BASH_VERSION" ]; then
  # Include .bashrc if it exists.
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

# Set PATH so it includes user's private bin if it exists.
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Source in all supplimentary profile scripts.
if [ -r "$HOME/.profile.d/__init__.sh" ] ; then
  . "$HOME/.profile.d/__init__.sh"
fi


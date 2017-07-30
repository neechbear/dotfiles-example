
# Setting environment variables DOTFILES_SYMLINK_SOURCE and
# DOTFILES_SYMLINK_TARGET will provide default values for the
# dotfiles-symlink-files command.
#if [ -n "$HOME" ] && [ -d "$HOME" ] && [ -z "$DOTFILES_SYMLINK_SOURCE" ] ; then
#  if [ -x "$HOME/src/rcfiles/bin/dotfiles.sh" ] ; then
#    DOTFILES_SYMLINK_SOURCE="$HOME/src/rcfiles"
#  fi
#  export DOTFILES_SYMLINK_SOURCE
#  export DOTFILES_SYMLINK_TARGET="$HOME"
#fi

if [ -z "$USER" ] && [ -z "$LOGNAME" ] && [ -x /usr/bin/id ] ; then
  export USER="$(id -un)"
  export LOGNAME="$USER"
fi

if [ -z "$TTY" ] && [ -n "$SSH_TTY" ] ; then
  export TTY="$SSH_TTY"
fi
if [ -z "$TTY" ] && [ -x /usr/bin/tty ] ; then
  export TTY="$(/usr/bin/tty)"
fi

export SYSTEM="$(uname -s)"
case "$SYSTEM" in
  Linux)   [ -d "$HOME/bin/linux"   ] && PATH="$PATH:$HOME/bin/linux"   ;;
  FreeBSD) [ -d "$HOME/bin/freebsd" ] && PATH="$PATH:$HOME/bin/freebsd" ;;
  Darwin)  [ -d "$HOME/bin/darwin"  ] && PATH="$PATH:$HOME/bin/darwin"  ;; 
esac

if [ -z "$HOSTNAME" ] ; then
  if [ -x /usr/bin/hostname ] ; then
    export HOSTNAME="$(/usr/bin/hostname -f)"
  elif [ -x /bin/hostname ] ; then
    export HOSTNAME="$(/bin/hostname -f)"
  fi
fi
[ -d "$HOME/bin/$HOSTNAME" ] && PATH="$PATH:$HOME/bin/$HOSTNAME"

export LESS="-g -m -M -R"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export HISTCONTROL=ignoreboth
export HISTSIZE=1000
export HISTFILESIZE=30000
export HISTTIMEFORMAT="%Y%m%d %T "

if [ -x /usr/bin/vi ] ; then
  EDITOR=/usr/bin/vi
fi
if [ -x /usr/bin/vim ] ; then
  EDITOR=/usr/bin/vim
fi
export EDITOR

if [ -e "$HOME/ansible.cfg" ] ; then
  ANSIBLE_CONFIG="$HOME/ansible.cfg"
fi
if [ -e "$HOME/ansible/ansible.cfg" ] ; then
  ANSIBLE_CONFIG="$HOME/ansible/ansible.cfg"
fi
export ANSIBLE_CONFIG

# https://superuser.com/questions/278286/making-256-color-and-line-drawing-characters-both-work-in-putty
# https://www.chiark.greenend.org.uk/~sgtatham/putty/wishlist/utf8-plus-vt100.html
# http://www.cl.cam.ac.uk/~mgk25/unicode.html#term
export NCURSES_NO_UTF8_ACS=1


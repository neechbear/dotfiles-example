
if [ -d ~/.profile.d ] ; then
  if [ -n "$BASH_VERSION" ] ; then
    for file in ~/.profile.d/[0-9]*.{sh,bash} ; do
      source "$file"
    done
  else
    for file in ~/.profile.d/[0-9]*.sh ; do
      . $file
    done
  fi
fi


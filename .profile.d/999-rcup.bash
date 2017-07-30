
RCUPLAST=~/.rcup.last
STALESECS=259200
MTIME=0

case "$(uname -s)" in
  Darwin)
    MTIME="$(stat -f '%m' $RCUPLAST 2>/dev/null)" || MTIME="0"
    ;;
  *)
    MTIME="$(stat -c '%Y' $RCUPLAST 2>/dev/null)" || MTIME="0"
    ;;
esac

if [[ -n "${SSH_AUTH_SOCK:-}" && \
    $(( $(printf '%(%s)T' -1) - ${MTIME:-0} )) -ge $STALESECS ]]; then
  "${BASH_SOURCE[0]%/*}/../bin/rcup"
  touch $RCUPLAST
fi


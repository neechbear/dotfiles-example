
__upower_prompt () {
  echo "${__UPOWER_PROMPT:-}"
}

if [[ ${BASH_VERSINFO[1]} -ge 4 ]] ; then
  export __UPOWER_LAST_UNIXTIME=0 __UPOWER_BATTERY="" __UPOWER_PROMPT=""

  __unixtime () {
    if [[ ${BASH_VERSINFO[2]} -lt 2 ]] ; then
      date +"%s"
    else
      printf "%(%s)T" -1
    fi
  }

  __upower_prompt_colour () {
    declare percent="${1:-}" time="${2:-}" fmt="${3:-}"

    declare colour="[0m"
    if [[ -n "${percent:-}" && "$percent" =~ ([0-9]+) ]] ; then
      declare p="${BASH_REMATCH[1]}"
      if [[ $p -lt 20 ]] ; then
        colour="[0;1;31m"
      elif [[ $p -lt 60 ]] ; then
        colour="[0;1;33m"
      else
        colour="[0;1;32m"
      fi
    fi

    time="${time// hours/h}"; time="${time// minutes/m}"
    #printf "%s$fmt%s" "\[$colour\]" "$percent" "$time" "\[[0m\]"
    printf "$fmt" "$percent" "$time"
  }
  
  __upower_data () {
    # Return early if we don't have the upower command.
    if ! type -P upower >/dev/null 2>&1 ; then
      return 0
    fi

    # Return early if we have a recent cache.
    declare -i now="$(__unixtime)" stale_secs=120
    declare -i diff_secs=$(( now - ${__UPOWER_LAST_UNIXTIME:-0} ))
    if [[ $diff_secs -lt $stale_secs ]] ; then
      return 0
    fi

    # Figure out what battery we're going to check.
    if [[ -z "${__UPOWER_BATTERY:-}" ]] ; then
      __UPOWER_BATTERY="$(upower -e | grep battery | head -n 1)"
    fi
    __UPOWER_BATTERY="${__UPOWER_BATTERY:-/org/freedesktop/UPower/devices/battery_BAT0}"

    # Parse battery information.
    declare -A __upower=()
    while read -r line ; do
      if [[ "$line" =~ ^[[:space:]]*([[:alnum:][:space:]-]+):[[:space:]]*(.+)[[:space:]]*$ ]]
      then
        __upower["${BASH_REMATCH[1]// /-}"]="${BASH_REMATCH[2]:-}"
      fi
    done < <(upower -i "$__UPOWER_BATTERY")

    # Set the new prompt.
    __UPOWER_PROMPT="${__upower[state]:-}"
    if [[    "${__upower[state]:-}" == "discharging" \
       && -n "${__upower[percentage]:-}" \
       && -n "${__upower[time-to-empty]:-}" ]] ; then
      __UPOWER_PROMPT="$(__upower_prompt_colour \
                      "${__upower[percentage]:-}" \
                      "${__upower[time-to-empty]}" \
                      "%s/%s")"
    fi

    # Save state.
    __UPOWER_LAST_UNIXTIME="$(__unixtime)"
    export __UPOWER_LAST_UNIXTIME __UPOWER_BATTERY __UPOWER_PROMPT
  }

  # Export command prompt hook.
  __upower_data
  if [[ -n "${__UPOWER_PROMPT:-}" \
     && ! "${PROMPT_COMMAND:-}" == *"__upower_data"* ]] \
     && type -P upower >/dev/null 2>&1 ; then\
    if [[ -n "${PROMPT_COMMAND:-}" && ! "${PROMPT_COMMAND:-}" =~ \;[[:space:]]* ]] 
    then
      PROMPT_COMMAND="${PROMPT_COMMAND:-};"
    fi
    export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND}__upower_data;"
  fi
fi


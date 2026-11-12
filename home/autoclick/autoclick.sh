# shellcheck shell=bash
# autoclick [delay] [clicks]
#   delay  = milliseconds from one left click to the next (default 1000)
#   clicks = stop after this many clicks (default: keep going)
# The first click comes at once. Run it again while it is going to stop it.
# No "#!" line on purpose: autoclick.nix wraps this file and adds it.
export YDOTOOL_SOCKET="${YDOTOOL_SOCKET:-/run/ydotoold/socket}"

if pkill -x ydotool; then
  ydotool click 0x80 >/dev/null # let go, in case it stopped mid-click
  exit 0
fi

delay="${1:-1000}"
clicks="${2:-2000000000}"
if (( delay < 2 || delay > 1800000 )); then
  echo "autoclick: the delay must be between 2 and 1800000 ms" >&2
  exit 1
fi

# ydotool has one pause length, used after every step. So each round is cut
# into n equal steps: press and release (0xC0), then n-2 that do nothing (0x00).
n=$(( delay < 50 ? 2 : delay / 25 ))
step=$(( delay / n ))
round=(0xC0)
for (( i = 2; i < n; i++ )); do round+=(0x00); done

exec ydotool click --repeat "$clicks" --next-delay "$step" "${round[@]}" >/dev/null

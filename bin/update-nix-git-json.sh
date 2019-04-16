#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash gitMinimal jq nix-prefetch-git
# shellcheck shell=bash

################################################################################
# Update JSON files that were generated by nix-prefetch-git.
set -e
set -u

################################################################################
option_default_directory=$(realpath "$(dirname "$0")/..")

################################################################################
if [ $# -eq 1 ] && [ "$1" = "-h" ]; then
  echo "Usage: $0 [files|directories]"
  echo ""
  echo "  Default: $option_default_directory"
fi

################################################################################
update_file() {
  local file=$1
  local url=$(jq -r .url "$file")

  if [ -n "$url" ]; then
    echo "==> $file"
    nix-prefetch-git --quiet "$url" > "$file"
  fi
}

################################################################################
update_directory() {
  local dir=$1

  while IFS= read -r -d '' file; do
    update_file "$file"
  done <  <(find "$dir" -type f -name '*.json' -print0)
}

################################################################################
update_thing() {
  local thing=$1

  if [ -d "$thing" ]; then
    update_directory "$thing"
  elif [ -e "$thing" ]; then
    update_file "$thing"
  else
    >&2 echo "ERROR: no such file or directory: $thing"
  fi
}

################################################################################
if [ $# -gt 0 ]; then
  for thing in "$@"; do
    update_thing "$thing"
  done
else
  update_directory "$option_default_directory"
fi

# Local Variables:
#   mode: sh
#   sh-shell: bash
# End:
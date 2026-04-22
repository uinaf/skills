#!/usr/bin/env bash

set -euo pipefail

all_tiles_json() {
  find skills -type f -name tile.json -exec dirname {} \; \
    | sort \
    | jq -Rsc 'split("\n") | map(select(length > 0))'
}

files_to_tiles_json() {
  local files_json="$1"

  if ! jq -e '. | type == "array"' >/dev/null <<<"$files_json"; then
    echo "expected JSON array of changed files" >&2
    exit 1
  fi

  if jq -e 'index(".github/workflows/publish-skills.yml") != null' >/dev/null <<<"$files_json"; then
    all_tiles_json
    return
  fi

  {
    jq -r '.[]?' <<<"$files_json" | grep '^skills/' || true
  } | while IFS= read -r path; do
        dir="$(dirname "$path")"
        while [ "$dir" != "." ] && [ "$dir" != "skills" ]; do
          if [ -f "$dir/tile.json" ]; then
            printf '%s\n' "$dir"
            break
          fi
          dir="$(dirname "$dir")"
        done
      done \
    | sort -u \
    | jq -Rsc 'split("\n") | map(select(length > 0))'
}

mode="${1:-}"

case "$mode" in
  --all)
    all_tiles_json
    ;;
  --files-json)
    if [ "$#" -ne 2 ]; then
      echo "usage: $0 --files-json <json-array>" >&2
      exit 1
    fi
    files_to_tiles_json "$2"
    ;;
  *)
    echo "usage: $0 --all | --files-json <json-array>" >&2
    exit 1
    ;;
esac

#!/usr/bin/env bash

set -euo pipefail

tile_dir="${1:-.}"
tile_json="$tile_dir/tile.json"
max_attempts="${MAX_PUBLISH_VERSION_ATTEMPTS:-20}"

if [[ ! -f "$tile_json" ]]; then
  echo "tile.json not found: $tile_json" >&2
  exit 1
fi

read_tile_version() {
  python3 - "$tile_json" <<'PY'
import json
import sys

with open(sys.argv[1], "r", encoding="utf-8") as fh:
    data = json.load(fh)

print(data["version"])
PY
}

bump_patch() {
  python3 - "$1" <<'PY'
import re
import sys

version = sys.argv[1]
match = re.fullmatch(r"(\d+)\.(\d+)\.(\d+)", version)
if not match:
    raise SystemExit(f"unsupported non-semver version: {version}")

major, minor, patch = map(int, match.groups())
print(f"{major}.{minor}.{patch + 1}")
PY
}

write_tile_version() {
  python3 - "$tile_json" "$1" <<'PY'
import json
import sys

path, version = sys.argv[1], sys.argv[2]
with open(path, "r", encoding="utf-8") as fh:
    data = json.load(fh)

data["version"] = version

with open(path, "w", encoding="utf-8") as fh:
    json.dump(data, fh, indent=2)
    fh.write("\n")
PY
}

current_version="$(read_tile_version)"

for ((attempt = 1; attempt <= max_attempts; attempt++)); do
  if output="$(cd "$tile_dir" && tessl tile publish --dry-run 2>&1)"; then
    echo "Resolved publish version: $current_version"
    exit 0
  fi

  if ! grep -q "already exists" <<<"$output"; then
    printf '%s\n' "$output" >&2
    exit 1
  fi

  next_version="$(bump_patch "$current_version")"
  write_tile_version "$next_version"
  echo "Bumped tile version from $current_version to $next_version after duplicate publish pre-check"
  current_version="$next_version"
done

echo "Could not find an available patch version after $max_attempts attempts" >&2
exit 1

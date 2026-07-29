#!/usr/bin/env bash
# Assert that a lean_olean_archive tarball is actually consumable: the expected
# olean is present, is a REGULAR FILE, and carries real bytes.
#
# The regular-file check is the load-bearing one. The import root the rule tars
# is a symlink farm into bazel-out, so an archive built without dereferencing
# still contains an entry at exactly this path — a dangling symlink to a
# build-time path that does not exist on the consumer's machine. A listing-only
# grep passes on that archive and it is useless. Assert the bytes, not the name.
set -euo pipefail

TARBALL="$1"
WANT="Lib/Thing.olean"

# `tar -C <root> .` prefixes entries with "./".
listing="$(tar tzf "$TARBALL")"
if ! printf '%s\n' "$listing" | grep -qE "(^|/)${WANT}\$"; then
  echo "FAIL: ${WANT} not in archive. Contents:" >&2
  printf '%s\n' "$listing" >&2
  exit 1
fi

# Long listing: entry type is the first character of the mode field.
# 'l' = symlink (not dereferenced — the bug), '-' = regular file (what we want).
entry="$(tar tvzf "$TARBALL" | grep -E "(^|/)${WANT}\$" | head -n 1)"
case "$entry" in
  l*)
    echo "FAIL: ${WANT} is a SYMLINK, not dereferenced content." >&2
    echo "      The archive points into bazel-out and is useless to consumers." >&2
    echo "      $entry" >&2
    exit 1
    ;;
  -*) ;;
  *)
    echo "FAIL: ${WANT} is neither a regular file nor a symlink:" >&2
    echo "      $entry" >&2
    exit 1
    ;;
esac

# And it must be non-empty — a dereferenced-but-truncated olean is still broken.
bytes="$(tar xzOf "$TARBALL" "./${WANT}" | wc -c | tr -d ' ')"
if [ "$bytes" -eq 0 ]; then
  echo "FAIL: ${WANT} extracted to 0 bytes." >&2
  exit 1
fi

echo "OK: ${WANT} present, regular file, ${bytes} bytes"

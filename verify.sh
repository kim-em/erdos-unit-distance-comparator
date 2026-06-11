#!/usr/bin/env bash
# Independently verify the solution with leanprover/comparator.
#
# Trust required: the Lean kernel, Mathlib, Challenge.lean (the statement),
# and comparator itself.  The proof in the ErdosUnitDistance library does
# NOT need to be trusted — comparator checks it independently.
set -euo pipefail

TOOLCHAIN_TAG=$(sed -e 's/^leanprover\/lean4://' lean-toolchain | tr -d '[:space:]')
WORK="${COMPARATOR_WORK:-$HOME/.cache/erdos-comparator}"
mkdir -p "$WORK"

if [ ! -d "$WORK/comparator" ]; then
  git clone --branch "$TOOLCHAIN_TAG" --depth 1 \
    https://github.com/leanprover/comparator "$WORK/comparator"
fi
if [ ! -d "$WORK/lean4export" ]; then
  git clone --branch "$TOOLCHAIN_TAG" --depth 1 \
    https://github.com/leanprover/lean4export "$WORK/lean4export"
fi
(cd "$WORK/comparator" && lake build)
(cd "$WORK/lean4export" && lake build)

if ! command -v landrun >/dev/null; then
  if [ ! -x "$WORK/landrun" ]; then
    curl -sL -o "$WORK/landrun" \
      https://github.com/Zouuup/landrun/releases/download/v0.1.14/landrun-linux-amd64
    chmod +x "$WORK/landrun"
  fi
  export PATH="$WORK:$PATH"
fi

export PATH="$WORK/lean4export/.lake/build/bin:$PATH"

lake exe cache get
lake env "$WORK/comparator/.lake/build/bin/comparator" comparator.json

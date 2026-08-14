# erdos-unit-distance-comparator

Independent verification, via
[leanprover/comparator](https://github.com/leanprover/comparator), that
the [ErdosUnitDistance](https://github.com/kim-em/erdos-unit-distance)
library really proves:

> **The uniform-constant form of Erdős's unit-distance conjecture is
> false** — for every `C > 0` there are arbitrarily large `n` admitting
> `n`-point planar sets with more than `n^(1 + C / log log n)`
> unit-distance pairs (L. Alpöge, 2026).

## What to audit

Only [`Challenge.lean`](Challenge.lean), which imports **only Mathlib**:
it defines the unit-distance count and states the theorem (with `sorry`).
If you believe `Challenge.lean` says what the theorem above says, then a
successful comparator run certifies that the library proves it using only
the axioms `propext`, `Quot.sound`, `Classical.choice` — without your
having to read or trust any of the proof code.

`Solution.lean` bridges the challenge statement to the library's theorem
by definitional equality; comparator rebuilds both modules in a sandbox,
exports them with `lean4export`, compares the statements, checks the
axioms, and replays the proof through the Lean kernel.

## Run it

```
./verify.sh
```

(Linux; downloads comparator, lean4export and landrun pinned to this
project's toolchain, fetches the Mathlib cache, and runs the check.
Expected final output: `Your solution is okay!`)

The same script runs in CI on every push — see the badge/workflow under
`.github/workflows/comparator.yml`.

## In the Palomar registry

Registered as
[PALOMAR-2026-08-08-000001](https://palomar-registry.org/entry.html?id=PALOMAR-2026-08-08-000001),
which runs the same comparison itself and publishes a rendered, hoverable
`Challenge.lean` beside the record, so the statement above can be read without
cloning anything.

A registered render is immutable: the bytes are what the record's hash is of.
So an improvement to how Palomar draws one reaches a reader through a new
version rather than by rewriting an old record, and a new version needs a
commit that has not been registered.

## Note for NixOS users

landrun needs the Nix store mounted read-only in its sandbox; wrap it as
`landrun --rox /nix/store "$@"` and put that wrapper first in `PATH`
before running `./verify.sh`.

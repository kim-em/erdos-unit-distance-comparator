/-
Copyright (c) 2026 Kim Morrison. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib

/-!
# Challenge: the uniform-constant Erdős unit-distance conjecture is false

This file is the human-auditable statement.  It imports only Mathlib.

For a finite `P ⊆ ℝ²`, `unitDist P` counts unordered pairs of points of
`P` at Euclidean distance exactly `1` (the metric of
`EuclideanSpace ℝ (Fin 2)`, not the sup-metric of `ℝ × ℝ`).

Erdős (1946) conjectured `ν(n) ≤ n^(1 + C / log log n)` for some
absolute constant `C` and all sufficiently large `n`.  The theorem below
is the literal negation: for every `C > 0` there are arbitrarily large
`n` admitting `n`-point sets with more than `n^(1 + C / log log n)`
unit-distance pairs (L. Alpöge, *Integral points on norm-one tori and
the Erdős unit-distance exponent*, 2026).
-/

open scoped Classical

namespace UnitDistance

/-- The number of unordered pairs `{x, y} ⊆ P` at Euclidean distance
exactly `1`. -/
noncomputable def unitDist (P : Finset (EuclideanSpace ℝ (Fin 2))) : ℕ :=
  (P.offDiag.filter (fun pq => dist pq.1 pq.2 = 1)).card / 2

/-- The uniform-constant form of Erdős's unit-distance conjecture is
false. -/
theorem erdos_unit_distance_uniform_constant_false :
    ∀ C : ℝ, 0 < C → ∀ N : ℕ,
      ∃ (n : ℕ) (P : Finset (EuclideanSpace ℝ (Fin 2))),
        N ≤ n ∧ P.card = n ∧
        (n : ℝ) ^ (1 + C / Real.log (Real.log n)) < (unitDist P : ℝ) := by
  sorry

end UnitDistance

/-
Copyright (c) 2026 Kim Morrison. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import ErdosUnitDistance

/-!
# Solution

The proof lives in the `ErdosUnitDistance` library
(<https://github.com/kim-em/erdos-unit-distance>); this file restates the
challenge definitions verbatim and bridges to the library's theorem by
definitional equality.
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
        (n : ℝ) ^ (1 + C / Real.log (Real.log n)) < (unitDist P : ℝ) :=
  Erdos.erdos_unit_distance_uniform_constant_false

end UnitDistance

/-
Fixtures for `lean_axiom_test`. Lean 4 core only — no Mathlib, no Batteries,
so this example costs a compile of two small files and the toolchain download
that every other example already pays for.

Three theorems, chosen so the allowlist is load-bearing rather than decorative:

  * `constructive`  — depends on NO axioms at all.
  * `classical`     — depends on `Classical.choice` (and `propext`), so an
                      allowlist of `[propext, Quot.sound]` must reject it while
                      the default three-axiom allowlist accepts it.
  * `quotiented`    — depends on `Quot.sound`, reached through `Nat`'s
                      well-founded machinery rather than written by hand.
-/

namespace Audited

/-- No axioms: definitional. -/
theorem constructive (n : Nat) : n + 0 = n := rfl

/-- Excluded middle. Needs `Classical.choice`. -/
theorem classical (p : Prop) : p ∨ ¬p := Classical.em p

/-- Uses `propext` via `Iff` rewriting. -/
theorem propositional (p q : Prop) (h : p ↔ q) : p = q := propext h

end Audited

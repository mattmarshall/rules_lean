/-
An ADMITTED goal, on purpose.

`//examples/axiom_audit:sorry_is_rejected` and `:admitted_is_rejected` are
NEGATIVE tests: both are expected to FAIL, and CI asserts that they do. They
are `manual`-tagged so `bazel test //...` does not pick them up.

Two independent gates should catch this file, and both are checked:
  * `forbid_sorry` on the compile — a `sorry` warning is a build failure;
  * `lean_axiom_test` — `sorryAx` is not in any allowlist here.
-/

namespace Audited

/-- Not a proof. Type-checks; `lean` exits 0; `#print axioms` says `sorryAx`. -/
theorem admitted (n : Nat) : n + 0 = n := by sorry

end Audited

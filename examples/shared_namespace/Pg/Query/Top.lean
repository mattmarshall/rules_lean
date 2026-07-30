/- Stands in for a SECOND published module that also owns `Pg/` — a different
   subdirectory, but the same top-level namespace. This is the case that used to
   fail: Lean resolves `Pg.Query.Top` in the first LEAN_PATH root owning `Pg/`
   (the catalog one) and does not fall through. -/
namespace Pg.Query

inductive Stmt where
  | createSchema (name : String) : Stmt
  deriving Repr

def sample : Stmt := .createSchema "graph"

end Pg.Query

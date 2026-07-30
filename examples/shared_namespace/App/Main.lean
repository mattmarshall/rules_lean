/- The consumer. Its own top-level namespace is `App`, deliberately DISJOINT
   from `Pg` — so neither dep collides with the consumer, and the old code sent
   both to LEAN_PATH as separate roots. Importing both is the regression test. -/
import Pg.Catalog.Tables
import Pg.Query.Top

example : Pg.Catalog.seed.name = "pg_catalog" := by native_decide

example : (Pg.Query.sample matches .createSchema "graph") = true := by native_decide

def main : IO Unit := IO.println "resolved both Pg-rooted deps"

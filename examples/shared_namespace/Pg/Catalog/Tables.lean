/- Stands in for a published catalog module: owns `Pg/Catalog/`. -/
namespace Pg.Catalog

structure Row where
  name : String
  deriving Repr

def seed : Row := { name := "pg_catalog" }

end Pg.Catalog

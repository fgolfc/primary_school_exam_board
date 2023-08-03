class DropCityAndMunicipality < ActiveRecord::Migration[6.0]
  def up
    drop_table :cities
    drop_table :municipalities
  end
  
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

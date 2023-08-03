class AddMunicipalityToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :municipality, null: false, foreign_key: true
  end
end

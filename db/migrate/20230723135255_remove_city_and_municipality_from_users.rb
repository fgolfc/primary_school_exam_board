class RemoveCityAndMunicipalityFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_reference :users, :city, index: true, foreign_key: true
    remove_reference :users, :municipality, index: true, foreign_key: true
  end
end

class RemoveLivingAreaFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :living_area, :integer
  end
end

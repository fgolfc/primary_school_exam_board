class AddNicknameAndLivingAreaToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :nickname, :string
    add_column :users, :living_area, :integer
  end
end

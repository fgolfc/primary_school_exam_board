class AddConfirmableToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :confirmation_token, :string unless column_exists?(:users, :confirmation_token)
    add_column :users, :confirmed_at, :datetime unless column_exists?(:users, :confirmed_at)
    add_column :users, :confirmation_sent_at, :datetime unless column_exists?(:users, :confirmation_sent_at)
    add_column :users, :unconfirmed_email, :string unless column_exists?(:users, :unconfirmed_email) # Only if using reconfirmable
    add_index :users, :confirmation_token, unique: true unless index_exists?(:users, :confirmation_token)
  end

  def down
    remove_column :users, :confirmation_token, :string if column_exists?(:users, :confirmation_token)
    remove_column :users, :confirmed_at, :datetime if column_exists?(:users, :confirmed_at)
    remove_column :users, :confirmation_sent_at, :datetime if column_exists?(:users, :confirmation_sent_at)
    remove_column :users, :unconfirmed_email, :string if column_exists?(:users, :unconfirmed_email) # Only if using reconfirmable
  end
end

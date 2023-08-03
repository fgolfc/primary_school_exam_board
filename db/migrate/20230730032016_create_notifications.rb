class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|

      t.integer :user_id, null: false
      t.integer :response_id
      t.integer :post_id
      t.string  :action,     default: '', null: false
      t.boolean :checked,    default: false, null: false
      t.timestamps
    end

      #検索の高速化の為の記述(add_index)
      add_index :notifications, :user_id
      add_index :notifications, :post_id
      add_index :notifications, :response_id
  end
end

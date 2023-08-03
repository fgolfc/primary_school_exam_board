class AddResponsesCountToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :responses_count, :integer, default: 0, null: false
  end
end

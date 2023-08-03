class AddLikesCountToResponses < ActiveRecord::Migration[6.0]
  def change
    add_column :responses, :likes_count, :integer, default: 0
  end
end

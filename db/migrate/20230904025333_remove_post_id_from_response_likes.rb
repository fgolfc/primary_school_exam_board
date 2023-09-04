class RemovePostIdFromResponseLikes < ActiveRecord::Migration[6.0]
  def change
    remove_column :response_likes, :post_id, :integer
  end
end

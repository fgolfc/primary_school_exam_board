class RemovePostIdFromResponseLikes < ActiveRecord::Migration[6.0]
  def change
    if column_exists?(:response_likes, :post_id)
      remove_column :response_likes, :post_id, :integer
    end
  end  
end

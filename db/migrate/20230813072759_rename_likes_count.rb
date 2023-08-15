class RenameLikesCount < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :likes_count, :post_likes_count
    rename_column :responses, :likes_count, :response_likes_count
  end
end

class AddIndexesAndForeignKeys < ActiveRecord::Migration[6.0]
  # 不正なデータを削除 (post_likesに対して)
  execute "DELETE FROM post_likes WHERE post_id NOT IN (SELECT id FROM posts)"
  # 不正なデータを削除 (response_likesに対して)
  execute "DELETE FROM response_likes WHERE response_id NOT IN (SELECT id FROM responses)"

  def change
    add_index :post_likes, :user_id, name: 'index_post_likes_on_user_id'
    add_index :post_likes, :post_id, name: 'index_post_likes_on_post_id'
    add_index :response_likes, :user_id, name: 'index_response_likes_on_user_id'
    add_index :response_likes, :response_id, name: 'index_response_likes_on_response_id'

    add_foreign_key :post_likes, :users
    add_foreign_key :post_likes, :posts
    add_foreign_key :response_likes, :users
    add_foreign_key :response_likes, :responses
  end
end

class AddResponsesLikesCountToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :responses_likes_count, :integer
  end
end

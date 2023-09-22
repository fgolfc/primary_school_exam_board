class PostLike < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }

  after_create :increment_post_likes_count
  after_destroy :decrement_post_likes_count

  private

  def increment_post_likes_count
    post.increment!(:post_likes_count)
  end

  def decrement_post_likes_count
    post.decrement!(:post_likes_count)
  end

end

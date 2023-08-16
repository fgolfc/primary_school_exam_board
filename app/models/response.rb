class Response < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_many :response_likes, dependent: :destroy

  validate :author_cannot_respond

  def likes_count
    self.response_likes_count
  end

  private

  def author_cannot_respond
    if user_id == post.user_id
      errors.add(:base, "質問者は回答できません。")
    end
  end

  def increment_post_responses_count
    Post.update_counters(post.id, responses_count: 1)
  end

  def decrement_post_responses_count
    Post.update_counters(post.id, responses_count: -1)
  end
end

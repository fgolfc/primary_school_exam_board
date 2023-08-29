class ResponseLike < ApplicationRecord
  belongs_to :user
  belongs_to :response

  validates :user_id, uniqueness: { scope: :response_id }

  after_create :increment_responses_likes_count
  after_destroy :decrement_responses_likes_count

  private

  def increment_responses_likes_count
    response.post.increment!(:responses_likes_count)
  end

  def decrement_responses_likes_count
    response.post.decrement!(:responses_likes_count)
  end
end

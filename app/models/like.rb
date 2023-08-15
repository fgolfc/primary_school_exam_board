class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true, counter_cache: :likes_count
  belongs_to :response, optional: true, counter_cache: :response_likes_count

  validate :either_post_or_response

  validates :user_id, uniqueness: { scope: :post_id }, if: -> { post_id.present? }
  validates :user_id, uniqueness: { scope: :response_id }, if: -> { response_id.present? }

  private

  def either_post_or_response
    errors.add(:base, "Either post or response must be present") unless post_id.blank? ^ response_id.blank?
  end
end

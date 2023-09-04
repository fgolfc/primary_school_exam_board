class Response < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_many :response_likes, dependent: :destroy

  validate :author_cannot_respond

  private

  def author_cannot_respond
    return unless post  # postがnilなら以降の処理をスキップ
    if user_id == post.user_id
      errors.add(:base, "質問者は回答できません。")
    end
  end  
end

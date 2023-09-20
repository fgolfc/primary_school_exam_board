class Post < ApplicationRecord
  belongs_to :user
  has_many :post_likes, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :title, presence: true
end

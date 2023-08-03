class Post < ApplicationRecord
  belongs_to :user
  has_many :post_likes
  has_many :response_likes
  has_many :responses
  has_many :notifications, dependent: :destroy
end

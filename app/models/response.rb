class Response < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_many :response_likes, dependent: :destroy
end

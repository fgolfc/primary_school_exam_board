class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true, counter_cache: true
  belongs_to :user
  belongs_to :response, counter_cache: true

  validates :user_id, uniqueness: { scope: [:likeable_type, :likeable_id] }
end

json.extract! response_like, :id, :response_id, :user_id, :created_at, :updated_at
json.url response_like_url(response_like, format: :json)

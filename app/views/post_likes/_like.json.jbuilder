json.extract! post_like, :id, :post_id, :user_id, :created_at, :updated_at
json.url post_like_url(post_like, format: :json)

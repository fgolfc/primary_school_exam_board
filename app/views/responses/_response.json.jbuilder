json.extract! response, :id, :body, :post_id, :created_at, :updated_at
json.url response_url(response, format: :json)

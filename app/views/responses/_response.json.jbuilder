json.extract! response, :id, :question, :response, :tags, :category, :created_at, :updated_at
json.url response_url(response, format: :json)

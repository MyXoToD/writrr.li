json.array!(@ratings) do |rating|
  json.extract! rating, :value, :users_id, :chapters_id
  json.url rating_url(rating, format: :json)
end

json.array!(@stories) do |story|
  json.extract! story, :title, :teaser, :genre, :users_id
  json.url story_url(story, format: :json)
end

json.array!(@chapters) do |chapter|
  json.extract! chapter, :title, :content, :stories_id
  json.url chapter_url(chapter, format: :json)
end

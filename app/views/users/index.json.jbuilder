json.array!(@users) do |user|
  json.extract! user, :username, :email, :password, :name, :image, :link, :location, :bio
  json.url user_url(user, format: :json)
end

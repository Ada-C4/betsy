json.array!(@users) do |user|
  json.extract! user, :id, :username, :email, :password_digest, :name
  json.url user_url(user, format: :json)
end

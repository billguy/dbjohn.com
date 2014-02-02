json.array!(@slogans) do |slogan|
  json.extract! slogan, :id
  json.url slogan_url(slogan, format: :json)
end

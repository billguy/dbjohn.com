json.array!(@blogs) do |blog|
  json.extract! blog, :id, :published, :title, :permalink, :content
  json.url blog_url(blog, format: :json)
end

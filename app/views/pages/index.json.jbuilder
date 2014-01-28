json.array!(@pages) do |page|
  json.extract! page, :id, :title, :permalink, :content, :javascript
  json.url page_url(page, format: :json)
end

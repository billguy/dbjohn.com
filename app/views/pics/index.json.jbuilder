json.array!(@pics) do |pic|
  json.extract! pic, :id, :published, :title, :attachment, :caption
  json.url pic_url(pic, format: :json)
end

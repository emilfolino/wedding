json.array!(@galleries) do |gallery|
  json.extract! gallery, :id, :gallery_name, :gallery_description, :flickr_id
  json.url gallery_url(gallery, format: :json)
end

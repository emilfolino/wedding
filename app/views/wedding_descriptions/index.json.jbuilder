json.array!(@wedding_descriptions) do |wedding_description|
  json.extract! wedding_description, :id, :body, :wedding_id, :language_id
  json.url wedding_description_url(wedding_description, format: :json)
end

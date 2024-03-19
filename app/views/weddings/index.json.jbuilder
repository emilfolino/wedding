json.array!(@weddings) do |wedding|
  json.extract! wedding, :id, :title, :description, :wedding_date, :user_id
  json.url wedding_url(wedding, format: :json)
end

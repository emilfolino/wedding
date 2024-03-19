json.array!(@gifts) do |gift|
  json.extract! gift, :id, :name, :url, :wedding_id, :user_id
  json.url gift_url(gift, format: :json)
end

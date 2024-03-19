json.array!(@pages) do |page|
  json.extract! page, :id, :page_title, :page_body, :wedding_id
  json.url page_url(page, format: :json)
end

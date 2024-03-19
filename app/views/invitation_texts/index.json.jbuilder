json.array!(@invitation_texts) do |invitation_text|
  json.extract! invitation_text, :id, :wedding_id, :language_id, :body
  json.url invitation_text_url(invitation_text, format: :json)
end

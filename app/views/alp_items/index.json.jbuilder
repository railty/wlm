json.array!(@alp_items) do |alp_item|
  json.extract! alp_item, :id
  json.url alp_item_url(alp_item, format: :json)
end

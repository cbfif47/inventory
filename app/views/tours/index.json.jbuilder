json.array!(@tours) do |tour|
  json.extract! tour, :id, :name, :current, :group_id
  json.url tour_url(tour, format: :json)
end

json.array!(@shows) do |show|
  json.extract! show, :id, :date, :venue
  json.url show_url(show, format: :json)
end

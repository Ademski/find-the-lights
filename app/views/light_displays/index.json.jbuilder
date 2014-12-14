json.array!(@light_displays) do |light_display|
  json.extract! light_display, :id, :name, :description
  json.url light_display_url(light_display, format: :json)
end

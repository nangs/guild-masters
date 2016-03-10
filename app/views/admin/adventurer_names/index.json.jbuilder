json.array!(@adventurer_names) do |adventurer_name|
  json.extract! adventurer_name, :id, :name
  json.url admin_adventurer_name_path(adventurer_name, format: :json)
end

class AdventurerNamesGrid

  include Datagrid

  scope do
    AdventurerName
  end

  filter(:name, :string) { |value| where("name like '%#{value}%'") }

  column(:name, :mandatory => true)

  column(:actions, :html => true, :mandatory => true) do |adventurer_name|
    link_to "Edit", edit_admin_adventurer_name_path(adventurer_name)
  end

  column(:actions, :html => true, :mandatory => true) do |adventurer_name|
    link_to "Delete", admin_adventurer_name_path(adventurer_name), method: :delete, data: { confirm: 'Are you sure?' }
  end
end

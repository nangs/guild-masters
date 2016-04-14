class AdventurerTemplatesGrid
  include Datagrid

  scope do
    AdventurerTemplate
  end

  filter(:max_hp, :integer, range: true)
  filter(:max_energy, :integer, range: true)
  filter(:attack, :integer, range: true)
  filter(:defense, :integer, range: true)
  filter(:vision, :integer, range: true)

  column(:id, mandatory: true)
  column(:max_hp, mandatory: true)
  column(:max_energy, mandatory: true)
  column(:attack, mandatory: true)
  column(:defense, mandatory: true)
  column(:vision, mandatory: true)

  column(:actions, html: true, mandatory: true) do |adventurer_template|
    link_to 'Edit', edit_admin_adventurer_template_path(adventurer_template)
  end

  column(:actions, html: true, mandatory: true) do |adventurer_template|
    link_to 'Delete', admin_adventurer_template_path(adventurer_template), method: :delete, data: { confirm: 'Are you sure?' }
  end
end

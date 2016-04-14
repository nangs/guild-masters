class MonsterTemplatesGrid

  include Datagrid

  scope do
    MonsterTemplate
  end

  filter(:name, :string) { |value| where("name like '%#{value}%'") }
  filter(:max_hp, :integer, :range => true)
  filter(:max_energy, :integer, :range => true)
  filter(:attack, :integer, :range => true)
  filter(:defense, :integer, :range => true)
  filter(:invisibility, :integer, :range => true)

  column(:name, :mandatory => true)
  column(:max_hp, :mandatory => true)
  column(:max_energy, :mandatory => true)
  column(:attack, :mandatory => true)
  column(:defense, :mandatory => true)
  column(:invisibility, :mandatory => true)

  column(:actions, :html => true, :mandatory => true) do |monster_template|
    link_to "Edit", edit_admin_monster_template_path(monster_template)
  end

  column(:actions, :html => true, :mandatory => true) do |monster_template|
    link_to "Delete", admin_monster_template_path(monster_template), method: :delete, data: { confirm: 'Are you sure?' }
  end
end

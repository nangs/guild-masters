class MonsterTemplatesGrid

  include Datagrid

  scope do
    MonsterTemplate
  end

  filter(:id, :integer)
  filter(:created_at, :date, :range => true)

  column(:id, :mandatory => true)
  column(:name, :mandatory => true)
  column(:max_hp, :mandatory => true)
  column(:max_energy, :mandatory => true)
  column(:attack, :mandatory => true)
  column(:defense, :mandatory => true)
  column(:invisibility, :mandatory => true)
  column(:actions, :html => true, :mandatory => true) do |monster_template|
    link_to "Delete", admin_monster_template_path(monster_template), method: :delete, data: { confirm: 'Are you sure?' }
  end
end

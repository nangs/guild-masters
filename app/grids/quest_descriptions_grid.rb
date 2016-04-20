class QuestDescriptionsGrid
  include Datagrid

  scope do
    QuestDescription
  end

  filter(:description, :string) { |value| where("description like '%#{value}%'") }

  column(:description, mandatory: true)

  column(:actions, html: true, mandatory: true) do |quest_description|
    link_to 'Edit', edit_admin_quest_description_path(quest_description)
  end

  column(:actions, html: true, mandatory: true) do |quest_description|
    link_to 'Delete', admin_quest_description_path(quest_description), method: :delete, data: { confirm: 'Are you sure?' }
  end
end

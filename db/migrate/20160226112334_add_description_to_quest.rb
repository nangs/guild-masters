class AddDescriptionToQuest < ActiveRecord::Migration
  def change
    add_column :quests, :description, :text
  end
end

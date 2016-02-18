class CreateAdventurersQuestEvents < ActiveRecord::Migration
  def change
    create_table :adventurers_quest_events, id: false do |t|
      t.belongs_to :adventurer, index: true
      t.belongs_to :quest_event, index: true
    end
  end
end

class AddQuestEventToQuest < ActiveRecord::Migration
  def change
    add_reference :quests, :quest_event, index: true, foreign_key: true
  end
end

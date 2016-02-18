class RemoveQuestEventFromQuest < ActiveRecord::Migration
  def change
    remove_reference :quests, :quest_event, index: true, foreign_key: true
  end
end

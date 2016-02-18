class RemoveQuestFromAdventurer < ActiveRecord::Migration
  def change
    remove_reference :adventurers, :quest, index: true, foreign_key: true
  end
end

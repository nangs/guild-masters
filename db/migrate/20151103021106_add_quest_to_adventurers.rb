class AddQuestToAdventurers < ActiveRecord::Migration
  def change
    add_reference :adventurers, :quest, index: true, foreign_key: true
  end
end

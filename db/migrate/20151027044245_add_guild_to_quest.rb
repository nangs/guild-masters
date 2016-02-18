class AddGuildToQuest < ActiveRecord::Migration
  def change
    add_reference :quests, :guild, index: true, foreign_key: true
  end
end

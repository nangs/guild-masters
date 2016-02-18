class AddGuildToAdventurer < ActiveRecord::Migration
  def change
    add_reference :adventurers, :guild, index: true, foreign_key: true
  end
end

class AddGuildToScoutEvent < ActiveRecord::Migration
  def change
    add_reference :scout_events, :guild, index: true, foreign_key: true
  end
end

class RemoveGuildmasterFromScoutEvent < ActiveRecord::Migration
  def change
    remove_reference :scout_events, :guildmaster, index: true, foreign_key: true
  end
end

class AddGuildmasterToGuild < ActiveRecord::Migration
  def change
    add_reference :guilds, :guildmaster, index: true, foreign_key: true
  end
end

class AddCurrentGuildIdToGuildmaster < ActiveRecord::Migration
  def change
    add_column :guildmasters, :current_guild_id, :integer
  end
end

class GuildUpgradeEvent < ActiveRecord::Base
  belongs_to :guild
  delegate :guildmaster, to: :guild

  def complete
    guild = self.guild
    guild.level = guild.level + 1
    gm = guildmaster
    gm.game_time = end_time
    gm.state = 'available'
    facilities = guild.facilities
    facMsg = []
    for fac in facilities
      fac.capacity = guild.level * 2
      fac.level = guild.level
      msg = { facility: fac, capacity: fac.capacity }
      facMsg << msg
      fac.save
    end
    guild.save
    gm.save
    completeMsg = { msg: :success, type: :UpgradeEvent, guild_level: guild.level, adventurer_room: guild.level * 5, quest_room: guild.level * 10, facility_capacity: facMsg }
    completeMsg
  end
end

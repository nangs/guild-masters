class GuildUpgradeEvent < ActiveRecord::Base
  belongs_to :guild
  delegate :guildmaster, to: :guild
  
  
  def complete
    guild = self.guild
    guild.level = guild.level+1
    gm =  self.guildmaster
    gm.game_time = self.end_time
    gm.state = "available"
    facilities = guild.facilities
    facMsg = Array.new
    for fac in facilities
      fac.capacity = guild.level*2
      msg={facility: fac, capacity: fac.capacity}
      facMsg<<msg
      fac.save
    end
    guild.save
    gm.save
    completeMsg = {msg: :"success", type: :"Upgrade Event", guild_level: guild.level, adventurer_room: guild.level*5, quest_room: guild.level*10, facility_capacity: facMsg}
    return completeMsg    
  end
end

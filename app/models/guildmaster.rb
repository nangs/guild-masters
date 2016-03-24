class Guildmaster < ActiveRecord::Base
  has_many :guilds, dependent: :destroy
  has_many :scout_events
  belongs_to :account

  # shortcuts to events
  has_many :scout_events, through: :guilds
  has_many :guild_upgrade_events, through: :guilds
  has_many :quests, through: :guilds
  has_many :quest_events, through: :quests
  has_many :facilities, through: :guilds
  has_many :facility_events, through: :facilities

  
  def build_guild
    guild = Guild.new
    guild.level = 1
    guild.popularity = 50
    guild.guildmaster = self
    clinic=Facility.new
    clinic.guild =guild
    clinic.name = "clinic"
    clinic.level = 1
    clinic.capacity=2
    clinic.save
    canteen=Facility.new
    canteen.guild =guild
    canteen.name = "canteen"
    canteen.level = 1
    canteen.capacity=2
    canteen.save
    guild.save
    return guild
  end
  
  def refresh
    guilds = self.guilds
    msgArray = Array.new
    for guild in guilds
      advs = Array.new
      qsts = Array.new
      nqst = guild.popularity/20+1
      nqst.times do
       qsts<<guild.create_quest
      end
      nadv = guild.popularity/40 + 1
      nadv.times do
        advs<<guild.create_adventurer
      end
      msg = {guild: guild, new_quests: qsts, new_adventurers: advs}
      msgArray<<msg
    end
    puts msgArray.inspect
    return msgArray
  end
  
end

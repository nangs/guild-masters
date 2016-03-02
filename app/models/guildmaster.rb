class Guildmaster < ActiveRecord::Base
  has_many :guilds, dependent: :destroy
  has_many :quests, through: :guilds
  has_many :quest_events, through: :quests
  belongs_to :account
  
  def build_guild
    guild = Guild.new
    guild.level = 1
    guild.popularity = 50
    guild.guildmaster = self
    clinic=facility.new
    clinic.guild =guild
    clinic.name = "clinic"
    clinic.level = 1
    clinic.capacity=2
    clinic.save
    canteen=facility.new
    canteen.guild =guild
    canteen.name = "canteen"
    canteen.level = 1
    canteen.capacity=2
    canteen.save
    guild.save
    return guild
  end
  
  
end

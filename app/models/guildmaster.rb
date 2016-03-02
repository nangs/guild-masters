class Guildmaster < ActiveRecord::Base
  has_many :guilds, dependent: :destroy
  belongs_to :account

  # shortcuts to quest_events and facility_events
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
  
  
end

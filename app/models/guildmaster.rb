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
    guild.save
    return guild
  end
  
  
end

class Guild < ActiveRecord::Base
	belongs_to :guildmaster
	has_many :quests, dependent: :destroy
	has_many :adventurers, dependent: :destroy
	
	def self.initialize
	  guild=Guild.new
	  guild.level = 1
	  guild.popularity = 50
	  guild.guildmaster_id = 1
	  guild.save
	  return guild
	end
end

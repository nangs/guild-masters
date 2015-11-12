class Guild < ActiveRecord::Base
	belongs_to :guildmaster
	has_many :quests, dependent: :destroy
	has_many :adventurers, dependent: :destroy

	#This function creates and saves a newly created Guild into the Database
	#It will return the newly created Guild to the controller
	def self.initialize
	  guild=Guild.new
	  guild.level = 1
	  guild.popularity = 50
	  guild.guildmaster_id = 1
	  guild.save
	  return guild
	end
end

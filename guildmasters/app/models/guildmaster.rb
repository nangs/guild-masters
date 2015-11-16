class Guildmaster < ActiveRecord::Base
	has_many :guilds, dependent: :destroy

	#This function creates and saves a newly created Guild Master into the Database
	#It will return the newly created Guild Master to the controller
	def self.get_info
	  gm=Guildmaster.find(1)
	  return gm
	end
	
end

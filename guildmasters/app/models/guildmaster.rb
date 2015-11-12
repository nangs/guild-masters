class Guildmaster < ActiveRecord::Base
	has_many :guilds, dependent: :destroy

	#This function creates and saves a newly created Guild Master into the Database
	#It will return the newly created Guild Master to the controller
	def self.initialize
	  gm=Guildmaster.new
	  gm.gold=1000
	  gm.game_time = 0
	  gm.state="free"
	  gm.save
	  template = AdventurerTemplate.new	#should be moved to AdventurerTemplate class
	  template.max_hp = 100
	  template.max_energy = 100
	  template.attack = 1000
	  template.defense=1000
	  template.vision =1000
	  template.region_id = 1
	  template.save
	  return gm
	end
	
end

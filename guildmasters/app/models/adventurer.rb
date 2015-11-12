class Adventurer < ActiveRecord::Base
	belongs_to :guild
	belongs_to :quest
	#This function returns a list of Adventurers to the controller
	def self.view_all
	  adventurers = Adventurer.all
	  return adventurers
	end

	#This function creates and saves an Adventurer into the Database
	#It will return the newly created Adventurer to the controller
	def self.generate
		@adventurer_names = ["Alex", "Daniel", "David", "John", "Ben", "Charles", "William", "Alvin", "Peter", "Nathan", "Howard" ]
	  template = AdventurerTemplate.find(1)
	  level = Guild.find(1).level
	  #level = 1
	  adventurer = Adventurer.new
	  adventurer.name = @adventurer_names.sample
	  adventurer.max_hp = level*template.max_hp
	  adventurer.hp=adventurer.max_hp
	  adventurer.max_energy = level*template.max_energy
	  adventurer.energy = adventurer.max_energy
	  adventurer.attack = level*template.attack
	  adventurer.defense = level*template.defense
	  adventurer.vision = level*template.vision
	  adventurer.state = "Pending"
	  adventurer.guild_id = Guild.find(1).id
	 # adventurer.guild_id = 1
	  adventurer.save
	  return adventurer
	end

end

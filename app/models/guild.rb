class Guild < ActiveRecord::Base
	belongs_to :guildmaster
	has_many :quests, dependent: :destroy
	has_many :facilities, dependent: :destroy
	has_many :adventurers, dependent: :destroy
	has_many :quest_events, through: :quests


	#This function creates a quest based on current level of guild
	def create_quest
	  quest=Quest.create(difficulty: self.level, state: "pending", reward: self.level*100)
	  quest.monster_template = MonsterTemplate.order("RANDOM()").first
	  quest.guild = self
	  quest.save
	  return quest
	end
	
	#This function creates an adventurer based on current level of guild
	def create_adventurer
	  template = AdventurerTemplate.order("RANDOM()").first
	  level = self.level
	  adventurer = Adventurer.create(
	                                 name: Adventurer.random_adventurer_name,
	                                 max_hp: template.max_hp*level,
	                                 max_energy: 100+level*10,
	                                 attack: template.attack*level,
	                                 defense: template.defense*level,
	                                 vision: template.vision*level,
	                                 state: "available"
	                                 )
	                                 
	  adventurer.hp=adventurer.max_hp
	  adventurer.energy = adventurer.max_energy
	  adventurer.guild = self
	  adventurer.save
	  return adventurer
	end

end

class Guild < ActiveRecord::Base
	belongs_to :guildmaster
	has_many :quests, dependent: :destroy
	has_many :facilities, dependent: :destroy
	has_many :adventurers, dependent: :destroy

	has_many :scout_events, dependent: :destroy
	has_many :guild_upgrade_events, dependent: :destroy
	has_many :quest_events, through: :quests
	has_many :facility_events, through: :facilities


	#This function creates a quest based on current level of guild
	def create_quest
	  r=Random.new
	  quest=Quest.create(difficulty: self.level+r.rand(0..1), state: "pending")
	  quest.reward = quest.difficulty*100+r.rand(0..25)*quest.difficulty
	  quest.monster_template = MonsterTemplate.order("RANDOM()").first
	  quest.guild = self
	  quest.description = "There is a %s near the village! Find someone to help us kill it!" % [quest.monster_template.name]
	  quest.save
	  return quest
	end
	
	#This function creates an adventurer based on current level of guild
	def create_adventurer
	  r=Random.new
	  template = AdventurerTemplate.order("RANDOM()").first
	  level = self.level
	  adventurer = Adventurer.create(
	                                 name: Adventurer.random_adventurer_name,
	                                 max_hp: template.max_hp*level+r.rand(0..200),
	                                 max_energy: 100+level*10+r.rand(0..10),
	                                 attack: template.attack*level+r.rand(0..20),
	                                 defense: template.defense*level+r.rand(0..15),
	                                 vision: template.vision*level+r.rand(0..10),
	                                 state: "available"
	                                 )
	                                 
	  adventurer.hp=adventurer.max_hp
	  adventurer.energy = adventurer.max_energy
	  adventurer.guild = self
	  adventurer.save
	  return adventurer
	end

end

class Quest < ActiveRecord::Base
	belongs_to :guild
	has_many :adventurer

	#This function returns a list of Quests to the controller
	def self.view_all
	  quests=Quest.all
	  return quests
	end

	#This function creates and saves a Quest into the Database
	#It will return the newly created Quest to the controller
	def self.generate
	  #level = Guild.find(1).level
	  level = 1
	  quest = Quest.new
	  quest.difficulty = level
	  quest.state = "pending"
	  quest.reward = 1000*quest.difficulty
	  #quest.guild_id=Guild.find(1).id
	  quest.guild_id = 1
	  quest.save
	  return quest
	end
	
	def self.get(_quest_id)
	  quest = Quest.find(_quest_id)
	  return quest
	end
	
	def self.assign(_quest_id,_adventurer_ids)
	  adventurers = Adventurer.find(_adventurer_ids)
	  quest=Quest.find(_quest_id)
	  quest.adventurers = adventurers
	  adventurers.state = "assigned"
	  adventurers.quest = quest
	  quest.state = "assigned"
	  quest.save
	  adventurers.save
	  return quest
	end
	
end

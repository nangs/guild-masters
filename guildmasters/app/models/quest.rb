class Quest < ActiveRecord::Base
	belongs_to :guild
	has_many :adventurer

	def self.view_all
	  quests=Quest.find(:all)
	  return quests
	end
	
	def self.generate
	  level = Guild.find(1).level
	  quest = Quest.new
	  quest.difficulty = level
	  quest.state = "pending"
	  quest.reward = 1000*quest.difficulty
	  quest.guild_id=Guild.find(1).id
	  quest.save
	  return quest
	end
end

class Adventurer < ActiveRecord::Base
  belongs_to :guild
  has_and_belongs_to_many :quest_events

  #This function returns a list of Adventurers to the controller
  def self.view_all
    adventurers = Adventurer.all
    return adventurers
  end
  #This function will generate adventurer name according to text file
  #Return a randomly chosen name
	def self.random_adventurer_name
		return File.readlines(Rails.root.join "app", "models", "adventurerNames.txt").sample
	end
  def self.generate(guild_id)
    guild = Guild.find(guild_id)
    return guild.create_adventurer
  end
end

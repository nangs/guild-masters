class Adventurer < ActiveRecord::Base
  belongs_to :guild
  belongs_to :quest
  #This function returns a list of Adventurers to the controller
  def self.view_all
    adventurers = Adventurer.all
    return adventurers
  end

	def self.random_adventurer_name
		return File.readlines(Rails.root.join "app", "models", "adventurerNames.txt").sample
	end

  #This function creates and saves an Adventurer into the Database
  #It will return the newly created Adventurer to the controller
  def self.generate
    template = AdventurerTemplate.find(1)
    level = Guild.find(1).level
    #level = 1
    adventurer = Adventurer.new
    adventurer.name = random_adventurer_name
    adventurer.max_hp = level*template.max_hp+Random.rand(1000)
    adventurer.hp=adventurer.max_hp
    adventurer.max_energy = level*template.max_energy+Random.rand(1000)
    adventurer.energy = adventurer.max_energy
    adventurer.attack = level*template.attack+Random.rand(100)
    adventurer.defense = level*template.defense+Random.rand(100)
    adventurer.vision = level*template.vision+Random.rand(100)
    adventurer.state = "Available"
    adventurer.guild_id = Guild.find(1).id
    # adventurer.guild_id = 1
    adventurer.save
    return adventurer
  end

  def return(quest)
    self.energy = self.energy - quest.difficulty*100-Random.rand(quest.difficulty*50)
    if(self.energy<=0)
      self.energy=0
    end
    self.state = "Available"
    self.save
  end
end

class Quest < ActiveRecord::Base
  belongs_to :guild
  has_many :adventurers
  #This function returns a list of Quests to the controller
  def self.view_all
    quests=Quest.all
    return quests
  end

  #This function creates and saves a Quest into the Database
  #It will return the newly created Quest to the controller
  def self.generate
    level = Guild.find(1).level
    quest = Quest.new
    quest.difficulty = level+Random.rand(2)
    quest.state = "pending"
    quest.reward = 1000*quest.difficulty+Random.rand(1000)
    quest.guild_id=Guild.find(1).id
    quest.save
    return quest
  end

  def self.get(_quest_id)
    quest = Quest.find(_quest_id)
    return quest
  end

  def self.assign(_quest_id,_adventurer_ids)
    quest=Quest.find(_quest_id)
    _adventurer_ids.each do |_adventurer_id|
      adventurer = Adventurer.find(_adventurer_id)
      adventurer.state = "assigned"
      adventurer.quest = quest
      adventurer.save
      quest.adventurers<<adventurer
    end
    quest.state = "assigned"
    quest.save
    return quest
  end

  def self.complete(quest_id)
    quest = Quest.find(quest_id)
    adventurers = quest.adventurers
    sum=0
    for adventurer in adventurers
      sum = sum + adventurer.attack + adventurer.defense + adventurer.vision
      adventurer.energy = adventurer.enegegy - quest.difficulty*100-Random.rand(difficulty*50)
      adventurer.state = "Available"
      adventurer.save
    end
    sum = sum/900
    gm = Guildmaster.find(1)
    if(sum>=quest.difficulty)
      quest.state="successful"
    gm.gold = gm.gold+quest.reward
    else
      quest.state="failed"
    end
    gm.save
    quest.save
  end
end

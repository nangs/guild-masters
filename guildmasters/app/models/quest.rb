class Quest < ActiveRecord::Base
  belongs_to :guild
  has_many :adventurers
  has_one :quest_event
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

  def self.get(quest_id)
    quest = Quest.find(quest_id)
    return quest
  end

  def self.assign(quest_id,adventurer_ids)
    quest=Quest.find(quest_id)
    adventurers = Adventurer.find(adventurer_ids)
    #error_message = "Error, not available"
    #if(quest.state == "assigned"||quest.state=="successful")
    #return error_message
    #end
    #adventurer_ids.each do |adventurer_id|
    #  adventurer = Adventurer.find(adventurer_id)
    # if(adventurer.state =="assigned"||adventurer.energy<=0)
    #  return error_message
    #  end
    #end
    #quest.adventurers.clear
    #adventurer_ids.each do |adventurer_id|
    #  adventurer = Adventurer.find(adventurer_id)
    #  adventurer.state = "assigned"
    #  adventurer.quest = quest
    #  adventurer.save
    #end
    return quest.assign(adventurers)
    #quest_event=QuestEvent.new

    #gm = Guildmaster.find(1)
    #quest_event.quest_id = quest.id
    #quest_event.start_time = gm.game_time
    #quest_event.end_time = quest_event.start_time + quest.difficulty*100+Random.rand(quest.difficulty*25)
    #quest_event.gold_spent = 0
    #quest_event.save
    #quest.quest_event_id=quest_event.id
    #quest.quest_event = quest_event
    #quest.state = "assigned"
    #quest.save
  end

  def assign(adventurers)
    error_message = "Error, not available"
    if(self.state == "assigned"||self.state=="successful")
      return error_message
    end
    self.adventurers.clear
    adventurers.each do |adventurer|
      if(adventurer.state =="assigned"||adventurer.energy<=0)
        return error_message
      else
        adventurer.state = "assigned"
        adventurer.quest = self
        adventurer.save
      end
    end
    quest_event = QuestEvent.new
    start_time = Guildmaster.find(1).game_time
    quest_event.setup(start_time,self)
    self.quest_event_id = quest_event.id
    self.quest_event = quest_event
    self.state = "assigned"
    self.save
  end

  def self.complete(quest_id)
    quest = Quest.find(quest_id)
    return quest.complete
  end
  
  def complete
    adventurers = self.adventurers
    sum=0
    for adventurer in adventurers
      sum = sum + adventurer.attack + adventurer.defense + adventurer.vision
      adventurer.return(self)
    end
    sum = sum/900
    gm = Guildmaster.find(1)
    guild = Guild.find(1)
    if(sum>=self.difficulty)
      self.state="successful"
      guild.popularity=guild.popularity+self.difficulty
      gm.gold = gm.gold+self.reward
      msg= "Quest completed! Your guild earned %d gold and %d popularity!" % [self.reward,self.difficulty]
    else
      self.state="failed"
      guild.popularity=guild.popularity-self.difficulty
      msg = "Quest failed! Your guild lost %d popularity" % self.difficulty
    end
    guild.save
    #if(quest.quest_event.end_time/1000>gm.game_time/1000)
    #Guild.refresh
    #end
    gm.game_time = self.quest_event.end_time
    gm.save
    self.adventurers.clear
    self.save
    self.quest_event.destroy
    return msg
  end

end

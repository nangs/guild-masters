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

  #This function is a interface to assign adventurers to quest, it calls the actuall logic
  #Return the result of assigning quest
  def self.assign(quest_id,adventurer_ids)
    quest=Quest.find(quest_id)
    adventurers = Adventurer.find(adventurer_ids)
    return quest.assign(adventurers)
  end

  #This function will check the availability of Quest and Adventures and assign them togather and generate a Quest event
  #I need to REFACTOR this....
  def assign(adventurers)
    error_message = "Error, not available"
    
    #Check Quest Status. Done by front end too
    if(self.state == "assigned"||self.state=="successful")
      return error_message
    end
    self.adventurers.clear
    
    #Check Adventurers Status. Done by front end too
    adventurers.each do |adventurer|
      if(adventurer.state =="assigned"||adventurer.energy<=0)
        return error_message
      else
        adventurer.state = "assigned"
        adventurer.quest = self
        adventurer.save
      end
    end
    
    #Generate quest event
    quest_event = QuestEvent.new
    quest_event.setup(self)
    self.quest_event_id = quest_event.id
    self.quest_event = quest_event
    self.state = "assigned"
    self.save
    return "Successfully assigned"
  end

  #This function compute the result of quest, clearing the association and return message of result
  #also need to REFACTOR
  def complete
    
    #Relief adventurers and calculate quest factor
    adventurers = self.adventurers
    sum=0
    for adventurer in adventurers
      sum = sum + adventurer.attack + adventurer.defense + adventurer.vision
      adventurer.return
    end
    sum = sum/900
    guild = self.guild
    gm=guild.guildmaster
    
    #Success/Fail judgement
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
    gm.game_time = self.quest_event.end_time
    gm.save
    self.adventurers.clear
    self.save
    self.quest_event.destroy
    return msg
  end

end

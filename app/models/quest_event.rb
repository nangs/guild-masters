class QuestEvent < ActiveRecord::Base
  belongs_to :quest
  has_and_belongs_to_many :adventurers
  accepts_nested_attributes_for :quest
  
  delegate :guild, to: :quest
  delegate :guildmaster, to: :quest

  def self.view_all
    events = QuestEvent.all
    return events
  end
  #This function compute the result of quest, clearing the association and return message of result
  def complete
    
    #Relief adventurers and calculate quest factor
    result = self.quest.battle(self.adventurers)
    guild = self.guild
    gm=self.guildmaster
    #Success/Fail judgement
    if(result[:result])
      self.quest.state="successful"
      guild.popularity=guild.popularity+self.quest.difficulty
      gm.gold = gm.gold+self.quest.reward
      msg= {msg: :"success",type: :"QuestEvent", gold_gain: self.quest.reward, popularity_gain: self.quest.difficulty,quest: self.quest,adventurers: self.adventurers, battle_log: result[:log]}
    else
      self.quest.state="failed"
      guild.popularity=guild.popularity-self.quest.difficulty
      msg = {msg: :"failed", type: :"QuestEvent", popularity_lost: self.quest.difficulty,quest: self.quest,adventurers: self.adventurers, battle_log: result[:log]}
    end
    for adv in self.adventurers
      if(adv.state == "dead")
        guild.popularity = guild.popularity/2
      end
    end
    guild.save
    gm.game_time = self.end_time
    gm.save
    self.save
    return msg
  end
  
  #This function will create the relationship between adventurer and quest_event and quest
  def self.assign(quest,adventurers)
    msg = {msg: :"error", detail: :"not available"}
    
    #Check Quest Status. Done by front end too
    if(quest.state == "assigned"||quest.state=="successful")
    return msg
    end

    #Check Adventurers Status. Done by front end too
    adventurers.each do |adventurer|
      if(adventurer.state =="assigned"||adventurer.state=="dead"||adventurer.energy<=0)
      return msg
      end
    end
    quest.state = "assigned"
    
    #Generate new quest_event
    qe = QuestEvent.new
    adventurers.each do |adventurer|
      adventurer.state = "assigned"
      adventurer.quest_events << qe
      adventurer.save
    end
    qe.quest=quest
    qe.start_time = quest.guild.guildmaster.game_time
    qe.end_time = qe.start_time + qe.time_cost
    qe.gold_spent=0
    qe.save
    quest.quest_events << qe
    quest.save
    msg = {msg: :"success"}
    return msg
  end
  
  #This function calculates the game time needed for the quest to complete
  def time_cost
    adv_vision=0
    adventurers = self.adventurers
    for adventurer in adventurers
      adv_vision = adv_vision + adventurer.vision
    end
    mon_invis = self.quest.difficulty*self.quest.monster_template.invisibility
    turns = mon_invis/adv_vision+1
    for adventurer in adventurers
      adventurer.vision = adventurer.vision + turns*self.quest.difficulty
      adventurer.save
    end
    return 100*self.quest.difficulty+50*turns
  end
end

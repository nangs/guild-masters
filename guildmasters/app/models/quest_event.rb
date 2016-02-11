class QuestEvent < ActiveRecord::Base
  belongs_to :quest
  has_and_belongs_to_many :adventurers
  accepts_nested_attributes_for :quest
  
  def self.view_all
    events = QuestEvent.all
    return events
  end
  #This function compute the result of quest, clearing the association and return message of result
  def complete
    
    #Relief adventurers and calculate quest factor
    result = self.quest.battle(self.adventurers)

    guild = self.quest.guild
    gm=guild.guildmaster
    
    #Success/Fail judgement
    if(result)
      self.quest.state="successful"
      guild.popularity=guild.popularity+self.quest.difficulty
      gm.gold = gm.gold+self.quest.reward
      msg= "Quest completed! Your guild earned %d gold and %d popularity!" % [self.quest.reward,self.quest.difficulty]
    else
      self.quest.state="failed"
      guild.popularity=guild.popularity-self.quest.difficulty
      msg = "Quest failed! Your guild lost %d popularity" % self.quest.difficulty
    end
    
    guild.save
    gm.game_time = self.end_time
    gm.save
    self.save
    return msg
  end
  
  #This function will create the relationship between adventurer and quest_event and quest
  def self.assign(quest,adventurers)
    qe= QuestEvent.new
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
    return qe
  end
  
  #This function calculates the game time needed for the quest to complete
  def time_cost
    adv_vision=0
    adventurers = self.adventurers
    for adventurer in adventurers
      adv_vision = adv_vision + adventurer.vision
    end
    mon_invis = self.quest.difficulty*self.quest.monster_template.invisibility
    return 100*self.quest.difficulty+100*mon_invis/adv_vision
  end
end

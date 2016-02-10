require 'monster.rb'
class Quest < ActiveRecord::Base
  belongs_to :guild
  has_many :quest_events
  belongs_to :monster_template
  
  #This function returns a list of Quests to the controller
  def self.view_all
    quests=Quest.all
    return quests
  end
  
  #This function is a interface to create a new quest
  def self.generate(guild_id)
    guild = Guild.find(guild_id)
    return guild.create_quest
  end
  
  #This function is a interface to assign adventurers to quest, it calls the actuall logic
  #Return the result of assigning quest
  def self.assign(quest_id,adventurer_ids)
    quest=Quest.find(quest_id)
    adventurers = Adventurer.find(adventurer_ids)
    return quest.assign(adventurers)
  end

  #This function will check the availability of Quest and Adventures and assign them togather and generate a Quest event
  def assign(adventurers)
    error_message = "Error, not available"
    
    #Check Quest Status. Done by front end too
    if(self.state == "assigned"||self.state=="successful")
      return error_message
    end
    self.adventurers.clear
    
    #Check Adventurers Status. Done by front end too
    adventurers.each do |adventurer|
      if(adventurer.state =="assigned"||adventurer.state=="dead"||adventurer.energy<=0)
        return error_message
      else
        adventurer.state = "assigned"
        adventurer.quest = self
        adventurer.save
      end
    end
    self.state = "assigned"
    self.adventurers = adventurers
    
    #Generate quest event
    self.create_quest_event(start_time: self.guild.guildmaster.game_time,
                            end_time: self.guild.guildmaster.game_time + self.time_cost, 
                            gold_spent: 0)
    self.save
    return "Successfully assigned"
  end

  #This function compute the result of quest, clearing the association and return message of result
  def complete
    
    #Relief adventurers and calculate quest factor
    adventurers = self.adventurers
    result = self.battle

    guild = self.guild
    gm=guild.guildmaster
    
    #Success/Fail judgement
    if(result)
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
    self.quest_event=nil
    return msg
  end
  
  #This function calculates the game time needed for the quest to complete
  def time_cost
    adv_vision=0
    adventurers = self.adventurers
    for adventurer in adventurers
      adv_vision = adv_vision + adventurer.vision
    end
    mon_invis = self.difficulty*self.monster_template.invisibility
    return 100*self.difficulty+100*mon_invis/adv_vision
  end
  
  #This function simulates the battle process when carry out a quest
  def battle
    
    adventurers = self.adventurers
    #Generate monster instance according to template
    monster = Monster.new(self.monster_template,self.difficulty)
    end_of_battle=false
    adv_victory = false
    turn = 0
    while(!end_of_battle)
      turn = turn+1
      #Adventurers` phase
      for adventurer in adventurers
        if(adventurer.hp>0)
          if(monster.hp>0)
            monster.hp=monster.hp-(adventurer.attack*adventurer.attack/monster.defense)
            if(monster.hp<0)
              monster.hp=0
            end
          end
        end
      end
      #Monster`s phase
      if(monster.hp>0)
        target = adventurers.sample
        target.hp = target.hp - (monster.attack*monster.attack/target.defense)
        #Adventurer was killed
        if(target.hp<=0)
          target.hp=0
          target.energy=0
          target.state = "dead"
          target.save
          adventurers.delete(target)
          if(adventurers.empty?)
            end_of_battle=true
          end
        end
      elsif(monster.hp==0)
        end_of_battle = true
        adv_victory=true
      end
    end
    #Energy cost calculation
    if(!adventurers.empty?)
      for adventurer in adventurers
        adventurer.energy = adventurer.energy - 10 - self.difficulty*5
        adventurer.state = "available"
      end
    end
    return adv_victory
  end
end

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


  #This function simulates the battle process when carry out a quest
  def battle(adventurers)
    #Generate monster instance according to template
    advs = adventurers.clone
    survivers = (0..advs.size-1).to_a
    monster = Monster.new(self.monster_template,self.difficulty)
    puts advs.inspect
    puts monster.inspect
    end_of_battle=false
    adv_victory = false
    turn = 0
    while(!end_of_battle)
      turn = turn+1
      puts turn
      #Adventurers` phase
      for adv_id in survivers
        adventurer = adventurers[adv_id]
        if(monster.hp>0)
          monster.hp=monster.hp-(adventurer.attack*adventurer.attack/monster.defense)
          puts "adventurer: %d >> monster: %d " % [adventurer.hp, monster.hp]
          if(monster.hp<0)
            monster.hp=0
          end
        end
      end
      #Monster`s phase
      if(monster.hp>0)
        target_id = survivers.sample
        target=advs[target_id]
        target.hp = target.hp - (monster.attack*monster.attack/target.defense)
        puts "monster: %d >> adventurers %d" % [monster.hp,target.hp]
        #Adventurer was killed
        if(target.hp<=0)
          target.hp=0
          target.energy=0
          target.state = "dead"
          survivers.delete(target_id)
          if(survivers.empty?)
          end_of_battle = true
          end
        end
      elsif(monster.hp==0)
        end_of_battle = true
        adv_victory=true
      end

    end
    #Energy cost calculation
    for adventurer in advs
      adventurer.energy = adventurer.energy - 5 - self.difficulty*5
      adventurer.state = "available" if adventurer.state == "assigned"
      adventurer.energy = 0 if adventurer.energy<0
      adventurer.save
    end
    puts adv_victory
    return adv_victory
  end
end

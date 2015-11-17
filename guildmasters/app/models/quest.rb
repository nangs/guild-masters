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
    error_message = "Error, not available"
    if(quest.state == "assigned"||quest.state=="successful")
    return error_message
    end
    adventurer_ids.each do |adventurer_id|
      adventurer = Adventurer.find(adventurer_id)
      if(adventurer.state =="assigned"||adventurer.energy<=0)
      return error_message
      end
    end
    quest.adventurers.clear
    adventurer_ids.each do |adventurer_id|
      adventurer = Adventurer.find(adventurer_id)
      adventurer.state = "assigned"
      adventurer.quest = quest
      adventurer.save
    end

    quest_event=QuestEvent.new

    gm = Guildmaster.find(1)
    quest_event.quest_id = quest.id
    quest_event.start_time = gm.game_time
    quest_event.end_time = quest_event.start_time + quest.difficulty*100+Random.rand(quest.difficulty*25)
    quest_event.gold_spent = 0
    quest_event.save
    quest.quest_event_id=quest_event.id
    quest.quest_event = quest_event
    quest.state = "assigned"
    quest.save
  end

  def self.complete(quest_id)
    quest = Quest.find(quest_id)
    adventurers = quest.adventurers
    sum=0
    for adventurer in adventurers
      sum = sum + adventurer.attack + adventurer.defense + adventurer.vision
      adventurer.energy = adventurer.energy - quest.difficulty*100-Random.rand(quest.difficulty*50)
      if(adventurer.energy<=0)
      adventurer.energy=0
      end
      adventurer.state = "Available"
      adventurer.save
    end
    sum = sum/900
    gm = Guildmaster.find(1)
    guild = Guild.find(1)
    if(sum>=quest.difficulty)
      quest.state="successful"
      guild.popularity=guild.popularity+quest.difficulty
      gm.gold = gm.gold+quest.reward
      msg= "Quest completed! Your guild earned %d gold and %d popularity!" % [quest.reward,quest.difficulty]
    else
      quest.state="failed"
      guild.popularity=guild.popularity-quest.difficulty
      msg = "Quest failed! Your guild lost %d popularity" % quest.difficulty
    end
    guild.save
    #if(quest.quest_event.end_time/1000>gm.game_time/1000)
      #Guild.refresh
    #end
    gm.game_time = quest.quest_event.end_time
    gm.save
    quest.adventurers.clear
    quest.save
    quest.quest_event.destroy
    return msg
  end
end

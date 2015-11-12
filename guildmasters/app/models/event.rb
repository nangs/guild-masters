class Event < ActiveRecord::Base
  #can the function name assign_quest be changed to a more suitable name?
  def self.assign_quest(adventurer_id,quest_id)
    event = Event.new
    event.start_time = Guildmaster.find(1).game_time
    quest=Quest.find(quest_id)
    event.end_time = start_time + quest.difficulty*100
    event.gold_spent=0
    event.type = "quest"
    event.save
    adventurer = Adventurer.find(adventurer_id)
    adventurer.state = "assigned"
    adventurer.save
    quest = Quest.find(quest_id)
    quest.state = "assigned"
    quest.save
    return event
  end
end

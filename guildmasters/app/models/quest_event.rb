class QuestEvent < ActiveRecord::Base
  belongs_to :quest
  accepts_nested_attributes_for :quest
  
  def self.view_all
    events = QuestEvent.all
    return events
  end
  
  #This function will construct a QuestEvent
  def setup(quest)
    self.quest_id = quest.id
    self.start_time = quest.guild.guildmaster.game_time
    self.end_time = self.start_time + quest.difficulty*100+Random.rand(quest.difficulty*25)
    self.gold_spent = 0
    self.save
  end
  
  #This is a interface that calls completion of quest of the event
  #Return result of the Quest
  def self.complete(event_id)
    event = QuestEvent.find(event_id)
    quest = event.quest
    return quest.complete   
  end
end

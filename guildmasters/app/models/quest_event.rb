class QuestEvent < ActiveRecord::Base
  belongs_to :quest
  accepts_nested_attributes_for :quest
  
  def self.view_all
    events = QuestEvent.all
    return events
  end
  
  def setup(start_time,quest)
    self.quest_id = quest.id
    self.start_time = start_time
    self.end_time = self.start_time + quest.difficulty*100+Random.rand(quest.difficulty*25)
    self.gold_spent = 0
    self.save
  end
  
  def self.complete(event_id)
    event = QuestEvent.find(event_id)
    return Quest.complete(event.quest_id)
    
  end
end

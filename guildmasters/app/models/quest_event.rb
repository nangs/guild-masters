class QuestEvent < ActiveRecord::Base
  belongs_to :quest
  accepts_nested_attributes_for :quest
  
  def self.view_all
    events = QuestEvent.all
    return events
  end
  
  def self.complete(event_id)
    event = QuestEvent.find(event_id)
    Quest.complete(event.quest_id)
    
  end
end

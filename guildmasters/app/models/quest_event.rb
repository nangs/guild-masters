class QuestEvent < ActiveRecord::Base
  belongs_to :quest
  has_and_belongs_to_many :adventurers
  accepts_nested_attributes_for :quest
  
  def self.view_all
    events = QuestEvent.all
    return events
  end
  
  #This is a interface that calls completion of quest of the event
  #Return result of the Quest
  def complete
    quest = self.quest
    return quest.complete   
  end
end

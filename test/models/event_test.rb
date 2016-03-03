require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "test complete next" do 
    QuestEvent.assign(quests(:TestQuest05),[adventurers(:Tester05)])
    QuestEvent.assign(quests(:TestQuest03),[adventurers(:Tester06)])
    FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester08)])
    FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester10)])
    FacilityEvent.assign(facilities(:TestFac02),[adventurers(:Tester09)])
    gm = guildmasters(:TestMaster02)
    Event.complete_next(gm)
    Event.complete_next(gm)
    
  end
  
  test "test complete" do 
    QuestEvent.assign(quests(:TestQuest05),[adventurers(:Tester05)])
    QuestEvent.assign(quests(:TestQuest03),[adventurers(:Tester06)])
    FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester08)])
    FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester10)])
    FacilityEvent.assign(facilities(:TestFac02),[adventurers(:Tester09)])
    gm = guildmasters(:TestMaster02)
    
    Event.complete(gm,10800)
  end
end

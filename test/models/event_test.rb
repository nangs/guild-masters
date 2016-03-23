require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "test complete" do 
    QuestEvent.assign(quests(:TestQuest05),[adventurers(:Tester05)])
    QuestEvent.assign(quests(:TestQuest03),[adventurers(:Tester06)])
    FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester08)])
    FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester10)])
    FacilityEvent.assign(facilities(:TestFac02),[adventurers(:Tester09)])
    gm = guildmasters(:TestMaster02)
    
    puts Event.complete(gm,20000).to_yaml.inspect
  end
end

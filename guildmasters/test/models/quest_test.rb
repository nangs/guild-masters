require 'test_helper'

class QuestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "assign" do
    adventurer = adventurers(:one)
    quest=quests(:one)
    adventurer.state = "assigned"
    adventurer.quest = quest
    quest.adventurers<<adventurer
    adventurer = adventurers(:two)
    adventurer.state = "assigned"
    adventurer.quest = quest
    quest.adventurers<<adventurer
    quest.state = "assigned"
     
    puts quest.adventurers.inspect
  end
end

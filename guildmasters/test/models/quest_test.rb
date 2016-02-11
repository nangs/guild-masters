require 'test_helper'
require 'monster.rb'

class QuestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "test assign" do
    assert_equal "Error, not available", quests(:TestQuest01).assign([adventurers(:Tester03)]), "Quest Already assigned"
    assert_equal "Error, not available", quests(:TestQuest04).assign([adventurers(:Tester03)]), "Quest Already successful"
    assert_equal "Error, not available", quests(:TestQuest03).assign([adventurers(:Tester01)]), "Adventurer Already assigned"
    assert_equal "Error, not available", quests(:TestQuest05).assign([adventurers(:Tester01)]), "Adventurer Already assigned"
    assert_equal "Error, not available", quests(:TestQuest03).assign([adventurers(:Tester04)]), "Adventurer Not Enough energy"
    
    assert_equal "Successfully assigned", quests(:TestQuest03).assign([adventurers(:Tester03)])
    assert_equal "Successfully assigned", quests(:TestQuest05).assign([adventurers(:Tester05)])
  end
  
  test "test status after assign" do
    quests(:TestQuest03).assign([adventurers(:Tester03)])
    assert_equal "assigned", adventurers(:Tester03).state
    assert_equal "assigned", quests(:TestQuest03).state
  end
  test "test battle single adventurer level 1" do
    quests(:TestQuest05).battle([adventurers(:Tester03)])
  end
  test "test battle single adventurer level 2" do
    quests(:TestQuest07).battle([adventurers(:Tester03)])
  end
  test "test battle single adventurer level 3" do
    quests(:TestQuest06).battle([adventurers(:Tester03)])
  end
  test "test battle 2 adventurers level 1" do
    quests(:TestQuest05).battle([adventurers(:Tester03),adventurers(:Tester05)])
  end
  test "test battle 2 adventurers level 2" do
    quests(:TestQuest07).battle([adventurers(:Tester03),adventurers(:Tester05)])
  end
  test "test battle 2 adventurers level 3" do
    quests(:TestQuest06).battle([adventurers(:Tester03),adventurers(:Tester05)])
  end
  test "test battle 3 adventurers level 3" do
    quests(:TestQuest06).battle([adventurers(:Tester03),adventurers(:Tester05),adventurers(:Tester06)])
  end
end

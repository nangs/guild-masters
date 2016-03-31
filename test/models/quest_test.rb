require 'test_helper'
require 'monster.rb'

class QuestTest < ActiveSupport::TestCase
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
  
  test "test battle energy cost" do
    quests(:TestQuest08).battle([adventurers(:Tester03)]).inspect
  end
end

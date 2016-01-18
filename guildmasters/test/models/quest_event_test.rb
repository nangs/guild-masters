require 'test_helper'

class QuestEventTest < ActiveSupport::TestCase
  test "test setup" do
    quest_events(:TestQE01).setup(quests(:TestQuest03))
    assert_equal guildmasters(:TestMaster01).game_time, quest_events(:TestQE01).start_time
    assert_equal 0, quest_events(:TestQE01).gold_spent
    assert_equal quests(:TestQuest03), quest_events(:TestQE01).quest
    assert_operator quest_events(:TestQE01).end_time, :>=, 10400
    assert_operator quest_events(:TestQE01).end_time, :<=, 10500
  end
  
end

require 'test_helper'

class QuestEventTest < ActiveSupport::TestCase

  test "create quest event based on quest 1" do
    q = Quest.create()
    q.quest_event = QuestEvent.create()
    qe = q.quest_event
    assert_same(q, qe.quest, "failed to create quest event")
  end  

  test "create quest event based on quest 2" do
    q = Quest.create()
    qe = q.create_quest_event()
    assert_same(q, qe.quest, "failed to create quest event")
  end
end

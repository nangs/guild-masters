require 'test_helper'

class QuestEventTest < ActiveSupport::TestCase
  test "test quest event complete" do
    qe = QuestEvent.assign(quests(:TestQuest06),[adventurers(:Tester03)])
    msg = qe.complete
    assert_equal 1,qe.adventurers.count
    assert_equal "Quest failed! Your guild lost 3 popularity",msg
  end
end

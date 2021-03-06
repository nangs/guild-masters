require 'test_helper'

class QuestEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'test assign' do
    error1 = { msg: :error, detail: :quest_not_available }
    error2 = { msg: :error, detail: :adventurer_not_available }
    success = { msg: :success }
    assert_equal error1, QuestEvent.assign(quests(:TestQuest01), [adventurers(:Tester03)]), 'Quest Already assigned'
    assert_equal error1, QuestEvent.assign(quests(:TestQuest04), [adventurers(:Tester03)]), 'Quest Already successful'
    assert_equal error2, QuestEvent.assign(quests(:TestQuest03), [adventurers(:Tester01)]), 'Adventurer Already assigned'
    assert_equal error2, QuestEvent.assign(quests(:TestQuest05), [adventurers(:Tester01)]), 'Adventurer Already assigned'
    assert_equal error2, QuestEvent.assign(quests(:TestQuest03), [adventurers(:Tester04)])
    assert_equal success, QuestEvent.assign(quests(:TestQuest03), [adventurers(:Tester03)])
    assert_equal success, QuestEvent.assign(quests(:TestQuest05), [adventurers(:Tester05)])
  end

  test 'test status after assign' do
    QuestEvent.assign(quests(:TestQuest03), [adventurers(:Tester03)])
    assert_equal 'assigned', adventurers(:Tester03).state
    assert_equal 'assigned', quests(:TestQuest03).state
  end
  test 'test quest event complete' do
    QuestEvent.assign(quests(:TestQuest05), [adventurers(:Tester03)])
    qe = quests(:TestQuest05).quest_events.first
    qe.complete
    assert_equal 1, qe.adventurers.count
  end
end

require 'test_helper'

class FacilityEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "test assign" do
    nospace = {msg: "error", detail: "not enough space in facility"}
    noavai =  {msg: "error", detail: "adventurer not available"}
    fullhp = {msg: "error", detail: "adventurer is already at full hp"}
    fullenergy= {msg: "error", detail: "adventurer is already at full energy"}
    nogold = {msg: "error", detail: "not enough gold"}
    success = {msg: "success"}
    
    assert_equal nospace, FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester07),adventurers(:Tester08),adventurers(:Tester09)])
    assert_equal noavai, FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester02)])
    assert_equal fullhp, FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester09)])
    puts adventurers(:Tester09).inspect
    assert_equal fullenergy, FacilityEvent.assign(facilities(:TestFac02),[adventurers(:Tester10)])
    assert_equal nogold, FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester07)])
    assert_equal success, FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester08)])
    assert_equal success, FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester10)])
    assert_equal success, FacilityEvent.assign(facilities(:TestFac02),[adventurers(:Tester09)])
    puts guildmasters(:TestMaster02).inspect
  end
end

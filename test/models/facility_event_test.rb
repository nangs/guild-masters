require 'test_helper'

class FacilityEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "test assign" do
    nospace = {msg: :"error", detail: :"This facility doesn`t have enough space."}
    noavai =  {msg: :"error", detail: :"An adventurer is currently not available."}
    fullhp = {msg: :"error", detail: :"An adventurer is already fully healed."}
    fullenergy= {msg: :"error", detail: :"An adventurer is already at full energy."}
    nogold = {msg: :"error", detail: :"You don`t have enough gold.Sad."}
    success = {msg: :"success"}
    
    assert_equal nospace, FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester07),adventurers(:Tester08),adventurers(:Tester09)])
    assert_equal noavai, FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester02)])
    assert_equal fullhp, FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester09)])

    assert_equal fullenergy, FacilityEvent.assign(facilities(:TestFac02),[adventurers(:Tester10)])
    assert_equal nogold, FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester07)])
    assert_equal success, FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester08)])
    assert_equal success, FacilityEvent.assign(facilities(:TestFac01),[adventurers(:Tester10)])
    assert_equal success, FacilityEvent.assign(facilities(:TestFac02),[adventurers(:Tester09)])

  end
  
  test "test complete" do
    success = {msg: :"success"}
    FacilityEvent.assign(facilities(:TestFac02),[adventurers(:Tester09)])
    qe=adventurers(:Tester09).facility_events.first
    assert_equal success,qe.complete
    assert_equal adventurers(:Tester09).max_hp, adventurers(:Tester09).hp

  end
end

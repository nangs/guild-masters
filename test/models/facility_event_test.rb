require 'test_helper'

class FacilityEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'test assign' do
    nospace = { msg: :error, detail: :not_enough_space }
    noavai =  { msg: :error, detail: :adventurer_busy }
    fullhp = { msg: :error, detail: :hp_is_full }
    fullenergy = { msg: :error, detail: :energy_is_full }
    nogold = { msg: :error, detail: :not_enough_gold }
    success = :success

    assert_equal nospace, FacilityEvent.assign(facilities(:TestFac01), [adventurers(:Tester07), adventurers(:Tester08), adventurers(:Tester09)])
    assert_equal noavai, FacilityEvent.assign(facilities(:TestFac01), [adventurers(:Tester02)])
    assert_equal fullhp, FacilityEvent.assign(facilities(:TestFac01), [adventurers(:Tester09)])

    assert_equal fullenergy, FacilityEvent.assign(facilities(:TestFac02), [adventurers(:Tester10)])
    assert_equal nogold, FacilityEvent.assign(facilities(:TestFac03), [adventurers(:Tester07)])
    msg = FacilityEvent.assign(facilities(:TestFac01), [adventurers(:Tester08)])
    assert_equal success, msg[:msg]
    msg = FacilityEvent.assign(facilities(:TestFac01), [adventurers(:Tester10)])
    assert_equal success, msg[:msg]
    msg = FacilityEvent.assign(facilities(:TestFac02), [adventurers(:Tester09)])
    assert_equal success, msg[:msg]
  end

  test 'test complete' do
    FacilityEvent.assign(facilities(:TestFac02), [adventurers(:Tester09)])
    fe = adventurers(:Tester09).facility_events.first
    msg = fe.complete[:msg]
    assert_equal :success, msg
    assert_equal adventurers(:Tester09).max_hp, adventurers(:Tester09).hp
  end
end

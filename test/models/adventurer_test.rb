require 'test_helper'

class AdventurerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Energy Cost after Return" do
    adventurers(:Tester01).return
    assert_operator adventurers(:Tester01).energy, :>=, 250
    assert_operator adventurers(:Tester01).energy, :<=, 500
    adventurers(:Tester02).return
    assert_equal 0, adventurers(:Tester02).energy
  end
  
  test "State after Return" do
    adventurers(:Tester01).return
    adventurers(:Tester02).return
    assert_equal "Available", adventurers(:Tester01).state
    assert_equal "Available", adventurers(:Tester02).state
  end
end

require 'test_helper'

class ScoutEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "test assign" do
    error = {msg: :"error"}
    success = {msg: :"success"}
    assert_equal error,ScoutEvent.assign(guilds(:TestGuild01),500,1000)
    assert_equal success,ScoutEvent.assign(guilds(:TestGuild02),500,500)
    assert_equal error,ScoutEvent.assign(guilds(:TestGuild01),500,400)
  end
  
  test "test complete" do
    guild = guilds(:TestGuild02)
    gm = guild.guildmaster
    ScoutEvent.assign(guild,500,500)
    msg = Event.complete_next(gm)
    puts msg.inspect
  end
end

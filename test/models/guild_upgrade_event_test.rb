require 'test_helper'

class GuildUpgradeEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "test assign busy" do
    guild = guilds(:TestGuild04)
    msg = guild.upgrade
    puts msg.inspect
    assert_equal :"error" , msg[:msg]
  end
  test "test assign gold" do
    guild = guilds(:TestGuild05)
    msg = guild.upgrade
    puts msg.inspect
    assert_equal :"error" , msg[:msg]
  end
  test "test assign popularity" do
    guild = guilds(:TestGuild06)
    msg = guild.upgrade
    puts msg.inspect
    assert_equal :"error" , msg[:msg]
  end
  test "test assign facility in use" do
    guild = guilds(:TestGuild07)
    msg = guild.upgrade
    puts msg.inspect
    assert_equal :"error" , msg[:msg]
  end
  test "test assign success" do
    guild = guilds(:TestGuild08)
    msg = guild.upgrade
    puts msg.inspect
    assert_equal :"success" , msg[:msg]
  end  
  
  test "test assign complete" do
    guild = guilds(:TestGuild08)
    msg = guild.upgrade
    puts msg.inspect
    gue = guild.guild_upgrade_events.first
    msg = gue.complete
    puts msg.inspect
  end  
end

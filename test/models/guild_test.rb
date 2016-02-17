require 'test_helper'

class GuildTest < ActiveSupport::TestCase

    test "create new quest" do
        quest = guilds(:TestGuild01).create_quest
        assert_equal guilds(:TestGuild01).level, quest.difficulty
        puts quest.to_yaml
    end
    
    test "create new adventurer" do
        adventurer = guilds(:TestGuild01).create_adventurer
        assert_equal guilds(:TestGuild01).level*10+100, adventurer.max_energy
        puts adventurer.to_yaml
    end
    
end

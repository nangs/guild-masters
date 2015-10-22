require 'test_helper'

class GuildTest < ActiveSupport::TestCase

    test "should delete guild when delete guildmaster" do
        guild = guilds(:one)
        guild.guildmaster.destroy
        assert_raises(ActiveRecord::RecordNotFound) {guild.reload}
    end
    
end

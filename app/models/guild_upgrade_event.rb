class GuildUpgradeEvent < ActiveRecord::Base
  belongs_to :guild
  delegate :guildmaster, to: :guild
end

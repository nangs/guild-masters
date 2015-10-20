class Guildmaster < ActiveRecord::Base
	has_many :guilds, dependent: :destroy
end

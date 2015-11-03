class Guildmaster < ActiveRecord::Base
	has_many :guilds, dependent: :destroy
	
	def initialize
	  gm=Guildmaster.new
	  gm.gold=1000
	  gm.game_time = 0
	  gm.state="free"
	end
	
end

class Adventurer < ActiveRecord::Base
	belongs_to :guild
	belongs_to :quest
end

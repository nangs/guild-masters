class Quest < ActiveRecord::Base
	belongs_to :guild
	has_many :adventurer
end

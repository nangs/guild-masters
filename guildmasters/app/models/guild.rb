class Guild < ActiveRecord::Base
	belongs_to :guildmaster
	has_many :quests, dependent: :destroy
	has_many :adventurers, dependent: :destroy
end

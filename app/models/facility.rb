class Facility < ActiveRecord::Base
	belongs_to :guild
	has_many :facility_events, dependent: :destroy
end
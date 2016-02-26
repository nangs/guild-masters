class FacilityEvent < ActiveRecord::Base
	belongs_to :facility
	belongs_to :adventurer
end

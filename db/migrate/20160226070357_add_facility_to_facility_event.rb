class AddFacilityToFacilityEvent < ActiveRecord::Migration
  def change
    add_reference :facility_events, :facility, index: true, foreign_key: true
  end
end

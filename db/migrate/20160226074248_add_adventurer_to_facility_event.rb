class AddAdventurerToFacilityEvent < ActiveRecord::Migration
  def change
    add_reference :facility_events, :adventurer, index: true, foreign_key: true
  end
end

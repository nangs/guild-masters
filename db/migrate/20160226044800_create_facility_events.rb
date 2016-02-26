class CreateFacilityEvents < ActiveRecord::Migration
  def change
    create_table :facility_events do |t|
      t.integer :start_time
      t.integer :end_time
      t.integer :gold_spent

      t.timestamps null: false
    end
  end
end

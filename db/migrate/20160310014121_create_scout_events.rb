class CreateScoutEvents < ActiveRecord::Migration
  def change
    create_table :scout_events do |t|
      t.integer :start_time
      t.integer :end_time
      t.integer :gold_spent

      t.timestamps null: false
    end

    add_reference :scout_events, :guildmaster, index: true, foreign_key: true
  end
end

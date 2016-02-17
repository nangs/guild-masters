class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :start_time
      t.integer :end_time
      t.integer :gold_spend

      t.timestamps null: false
    end
  end
end

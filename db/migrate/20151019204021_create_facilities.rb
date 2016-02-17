class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.integer :level

      t.timestamps null: false
    end
  end
end

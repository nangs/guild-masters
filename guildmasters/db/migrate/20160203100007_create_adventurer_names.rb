class CreateAdventurerNames < ActiveRecord::Migration
  def change
    create_table :adventurer_names do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end

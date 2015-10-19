class CreateAdventurers < ActiveRecord::Migration
  def change
    create_table :adventurers do |t|
      t.integer :hp
      t.integer :max_hp
      t.integer :energy
      t.integer :max_energy
      t.integer :attack
      t.integer :defense
      t.integer :vision
      t.string :state

      t.timestamps null: false
    end
  end
end

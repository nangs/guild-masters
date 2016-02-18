class CreateAdventurerTemplates < ActiveRecord::Migration
  def change
    create_table :adventurer_templates do |t|
      t.integer :max_hp
      t.integer :max_energy
      t.integer :attack
      t.integer :defense
      t.integer :vision
      t.references :region, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

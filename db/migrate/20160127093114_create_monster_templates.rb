class CreateMonsterTemplates < ActiveRecord::Migration
  def change
    create_table :monster_templates do |t|
      t.string :name
      t.integer :max_hp
      t.integer :max_energy
      t.integer :attack
      t.integer :defense
      t.integer :invisibility

      t.timestamps null: false
    end
  end
end

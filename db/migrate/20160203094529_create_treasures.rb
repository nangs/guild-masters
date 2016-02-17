class CreateTreasures < ActiveRecord::Migration
  def change
    create_table :treasures do |t|
      t.string :name
      t.integer :invisibility

      t.timestamps null: false
    end
  end
end

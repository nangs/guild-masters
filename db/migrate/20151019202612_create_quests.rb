class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.integer :difficulty
      t.string :state
      t.integer :reward

      t.timestamps null: false
    end
  end
end

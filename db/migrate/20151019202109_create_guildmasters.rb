class CreateGuildmasters < ActiveRecord::Migration
  def change
    create_table :guildmasters do |t|
      t.integer :gold
      t.integer :game_time
      t.string :state

      t.timestamps null: false
    end
  end
end

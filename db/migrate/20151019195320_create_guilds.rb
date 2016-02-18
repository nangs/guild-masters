class CreateGuilds < ActiveRecord::Migration
  def change
    create_table :guilds do |t|
      t.integer :level
      t.integer :popularity

      t.timestamps null: false
    end
  end
end

class CreateGuildUpgradeEvents < ActiveRecord::Migration
  def change
    create_table :guild_upgrade_events do |t|
      t.integer :start_time
      t.integer :end_time
      t.integer :gold_spent
      t.references :guild, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

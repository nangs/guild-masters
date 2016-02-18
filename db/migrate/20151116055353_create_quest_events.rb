class CreateQuestEvents < ActiveRecord::Migration
  def change
    create_table :quest_events do |t|
      t.references :quest, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

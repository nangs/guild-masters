class CreateQuestDescriptions < ActiveRecord::Migration
  def change
    create_table :quest_descriptions do |t|
      t.text :description
      t.timestamps null: false
    end
  end
end

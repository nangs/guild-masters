class AddDetailsToQuestEvents < ActiveRecord::Migration
  def change
    add_column :quest_events, :start_time, :integer
    add_column :quest_events, :end_time, :integer
    add_column :quest_events, :gold_spent, :integer
  end
end

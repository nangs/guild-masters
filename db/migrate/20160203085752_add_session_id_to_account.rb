class AddSessionIdToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :session_id, :integer
  end
end

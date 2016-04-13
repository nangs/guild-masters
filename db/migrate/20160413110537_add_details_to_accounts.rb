class AddDetailsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :is_logged_in, :boolean, default: false
    add_column :accounts, :num_failed_attempts, :integer, default: 0
  end
end

class AddDetailsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :is_logged_in, :boolean
    add_column :accounts, :num_failed_attempts, :integer
  end
end

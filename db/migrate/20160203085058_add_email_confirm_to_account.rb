class AddEmailConfirmToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :email_confirmed, :boolean, default: false
    add_column :accounts, :confirm_token, :string
  end
end

class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :user_name
      t.string :password
      t.string :email_address

      t.timestamps null: false
    end
  end
end

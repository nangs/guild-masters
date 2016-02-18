class AddAccountToGuildmaster < ActiveRecord::Migration
  def change
    add_reference :guildmasters, :account, index: true, foreign_key: true
  end
end

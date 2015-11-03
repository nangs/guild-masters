class AddNameToAdventurer < ActiveRecord::Migration
  def change
    add_column :adventurers, :name, :string
  end
end

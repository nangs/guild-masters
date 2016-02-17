class AddNameToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :name, :string
  end
end

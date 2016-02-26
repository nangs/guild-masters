class AddCapacityToFacility < ActiveRecord::Migration
  def change
    add_column :facilities, :capacity, :integer
  end
end

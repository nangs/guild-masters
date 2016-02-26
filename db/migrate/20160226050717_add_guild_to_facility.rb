class AddGuildToFacility < ActiveRecord::Migration
  def change
    add_reference :facilities, :guild, index: true, foreign_key: true
  end
end

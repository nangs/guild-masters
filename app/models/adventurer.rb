class Adventurer < ActiveRecord::Base
  belongs_to :guild
  has_many :facility_events
  has_and_belongs_to_many :quest_events

  # This function returns a list of Adventurers to the controller
  def self.view_all
    adventurers = Adventurer.all
    adventurers
  end

  # This function will generate an adventurer name from entries in adventurer_names
  # Return a randomly chosen name
  def self.random_adventurer_name
    AdventurerName.order('RANDOM()').first.name
  end
end

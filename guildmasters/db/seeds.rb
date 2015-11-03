# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

5.times do |i|
  Adventurer.create(hp: 100*i, 
  	                max_hp: 100*i+200, 
  	                energy: 50*i, 
  	                max_energy: 60*i,
  	                attack: 100,
  	                defense: 50+i,
  	                vision: i,
  	                state: "available")

  Quest.create(difficulty: i,
  	           state: "ongoing",
  	           reward: 100+i)
end
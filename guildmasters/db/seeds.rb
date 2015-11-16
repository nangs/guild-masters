# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

gm = Guildmaster.create(gold: 20,
	                    game_time: 10000)

guild = gm.guilds.create(level: 3, popularity: 30)


# 5.times do |i|
#   guild.adventurers.create(hp: 100+i, 
#   	                    max_hp: 120+i, 
#   	                    energy: 50+i, 
#   	                    max_energy: 60+i,
#   	                    attack: 100,
#   	                    defense: 50+i,
#   	                    vision: 100+i,
#   	                    state: "available",
#   	                    name: "adventurer#{i}")

#   Quest.create(difficulty: 1+i,
#   	           state: "ongoing",
#   	           reward: 100+i)
# end

AdventurerTemplate.create(max_hp: 1000,
	                      max_energy: 1000,
	                      attack: 100,
	                      defense: 100,
	                      vision: 100)
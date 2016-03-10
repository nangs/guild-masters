class ScoutEvent < ActiveRecord::Base
	belongs_to :guildmaster
	def self.assign(guild,time,gold)
	  gm = guild.guildmaster
	  if(gm.state!="available"||gm.gold<gold)
	    return {msg: :"error"}
	  end
	  se = ScoutEvent.new
    se.guildmaster = gm
	  se.start_time = gm.game_time
	  se.end_time = gm.game_time + time
	  se.gold_spent = gold
	  gm.gold = gm.gold - gold
	  gm.state = "scouting"
	  se.save
	  gm.save
	  return {msg: :"success"}
	end
	
	def complete
	  time = self.end_time - self.start_time
	  nadv = time/300
	  if(nadv>=3)
	    nadv = 3
	  end
	  if(nadv==0)
	    nadv = 1
	  end
	  nque = time/200
	  if(nque>=5)
      nque = 5
    end
    if(nque==0)
      nadv = 1
    end
    advs = Array.new
    qsts = Array.new
    nadv.times do
	    template = AdventurerTemplate.order("RANDOM()").first
      level = self.level
      adventurer = Adventurer.create(
                                     name: Adventurer.random_adventurer_name,
                                     max_hp: template.max_hp*level + gold/50,
                                     max_energy: 100+level*10+gold/200,
                                     attack: template.attack*level+gold/100,
                                     defense: template.defense*level+gold/100,
                                     vision: template.vision*level+gold/200,
                                     state: "available"
                                     )
                                     
      adventurer.hp=adventurer.max_hp
      adventurer.energy = adventurer.max_energy
      adventurer.guild = self
      adventurer.save
      advs<<adventurer
    end
    nque.times do 
      r=Random.new
      quest=Quest.create(difficulty: self.level+r.rand(0..1), state: "pending")
      quest.reward = quest.difficulty*(100+gold/10)
      quest.monster_template = MonsterTemplate.order("RANDOM()").first
      quest.guild = self
      quest.description = "There is a %s near the village! Find someone to help us kill it!" % [quest.monster_template.name]
      quest.save
      qsts<<quest
    end
    gm.game_time = self.end_time
    gm.state = "available"
    gm.save
    return {msg: :"success", adv_gain: nadv, qst_gain: nque, adventurers: advs, quests: qsts}
	end
end

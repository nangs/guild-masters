class ScoutEvent < ActiveRecord::Base
	belongs_to :guild
  delegate :guildmaster, to: :guild
	def self.assign(guild,time,gold)
	  gm = guild.guildmaster
	  if(gm.state!="available")
	    return {msg: :"error", detail: :"guildmaster_busy"}
	  end
	  if(guild.is_full)
	    return {msg: :"error", detail: :"guild_full"}
	  end
	  if(gm.gold<gold)
	    return {msg: :"error", detail: :"not_enough_gold"}
	  end
	  guild.scout_events.create(start_time:gm.game_time,
	                            end_time:gm.game_time+time,
	                            gold_spent:gold)
	  gm.gold = gm.gold - gold
	  gm.state = "scouting"
	  guild.save
	  gm.save
	  return {msg: :"success"}
	end
	
	def complete
	  r = Random.new
	  time = self.end_time - self.start_time
	  gold = self.gold_spent
	  gm = self.guildmaster
	  nadv = time/300
	  if(nadv>=3)
	    nadv = 3
	  end
	  nque = time/200
	  if(nque>=5)
      nque = 5
    end
    advs = Array.new
    qsts = Array.new
    nadv.times do
      if(self.guild.adv_count<self.guild.level*5)
  	    template = AdventurerTemplate.order("RANDOM()").first
        level = self.guild.level
        adventurer = Adventurer.create(
                                       name: Adventurer.random_adventurer_name,
                                       max_hp: template.max_hp*level + gold/50+r.rand(50..200),
                                       max_energy: 100+level*10+gold/200+r.rand(0..10),
                                       attack: template.attack*level+gold/100+r.rand(0..10),
                                       defense: template.defense*level+gold/100+r.rand(0..10),
                                       vision: template.vision*level+gold/200+r.rand(0..10),
                                       state: "available"
                                       )
                                       
        adventurer.hp=adventurer.max_hp
        adventurer.energy = adventurer.max_energy
        adventurer.save
        self.guild.adventurers<<adventurer
        advs<<adventurer
      end
    end
    nque.times do 
      if(self.guild.qst_count<self.guild.level*10)
        r=Random.new
        quest=Quest.create(difficulty: self.guild.level+r.rand(0..1), state: "pending")
        quest.reward = quest.difficulty*(100+gold/10)+r.rand(0..100)
        quest.monster_template = MonsterTemplate.order("RANDOM()").first
        quest.description = "There is a %s near the village! Find someone to help us kill it!" % [quest.monster_template.name]
        quest.save
        self.guild.quests<<quest
        qsts<<quest
      end
    end
    gm.game_time = self.end_time
    gm.state = "available"
    gm.save
    return {msg: :"success", type: :"ScoutEvent", adv_gain: advs.size, qst_gain: qsts.size, adventurers: advs, quests: qsts, adv_dropped: nadv-advs.size, qst_dropped: nque-qsts.size}
	end
end

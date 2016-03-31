class Guild < ActiveRecord::Base
	belongs_to :guildmaster
	has_many :quests, dependent: :destroy
	has_many :facilities, dependent: :destroy
	has_many :adventurers, dependent: :destroy

	has_many :scout_events, dependent: :destroy
	has_many :guild_upgrade_events, dependent: :destroy
	has_many :quest_events, through: :quests
	has_many :facility_events, through: :facilities
	
	#Upgrade the guild, creates an guild upgrade event
  def upgrade
    gm = self.guildmaster
    if(self.is_upgradable)
      
      
      gm.state = "upgrading"
      self.guild_upgrade_events.create(start_time: gm.game_time, end_time: gm.game_time+self.level*1000, gold_spent: 2000*(self.level+1))
      gm.gold = gm.gold - 2000*(self.level+1)
      gm.save
      self.save
      
      msg = {msg: :"success", gold_spend: 2000*(self.level+1), time_cost: self.level}
      return msg
    else
      if(gm.state!="available")
        return {msg: :"error", detail: :"Guildmaster is busy now."}
      end
      if(gm.gold<2000*(self.level+1))
        return {msg: :"error", detail: :"Not enough gold.", require: 2000*(self.level+1)}
      end
      facilities = self.facilities
      for fac in facilities
        if(fac.capacity!=fac.level*2)
          return {msg: :"error", detail: :"You have facility in use, complete the event before upgrading the guild.", facility: fac}
        end
      end
      if(self.popularity<100*(2**(self.level-1)))
        return {msg: :"error", detail: :"Your guild`s popularity is not enough for upgrading", require: 100*(2**(self.level-1))-self.popularity}
      end
    end
  end
  #Check whether the guild is upgradable, return true if it passes all the checks, else return false
  def is_upgradable
    gm=self.guildmaster
    if(gm.state!="available")
      return false
    end
    if(gm.gold<2000*(self.level+1))
      return false
    end
    facilities = self.facilities
    for fac in facilities
      if(fac.capacity!=fac.level*2)
        return false
      end
    end
    if(self.popularity<100*(2**(self.level-1)))
      return false
    end
    return true
  end
  #Return information of the guild, including the popularity requirement, gold requirement and whether it is upgradable
  def get_info
    return {level: self.level, 
      popularity: self.popularity, 
      pop_requirement: 100*(2**(self.level-1)), 
      gold_requirement: 2000*(self.level+1), 
      adventurer_capacity: self.level*5,
      quest_capacity: self.level*10,
      is_upgradable: self.is_upgradable}
  end
	#This function creates a quest based on current level of guild
	def create_quest
	  r=Random.new
	  quest=Quest.create(difficulty: self.level+r.rand(0..1), state: "pending")
	  quest.reward = quest.difficulty*100+r.rand(0..25)*quest.difficulty
	  quest.monster_template = MonsterTemplate.order("RANDOM()").first
	  quest.guild = self
	  quest.description = "There is a %s near the village! Find someone to help us kill it!" % [quest.monster_template.name]
	  quest.save
	  return quest
	end
	
	#This function creates an adventurer based on current level of guild
	def create_adventurer
	  r=Random.new
	  template = AdventurerTemplate.order("RANDOM()").first
	  level = self.level
	  adventurer = Adventurer.create(
	                                 name: Adventurer.random_adventurer_name,
	                                 max_hp: template.max_hp*level+r.rand(0..200),
	                                 max_energy: 100+level*10+r.rand(0..10),
	                                 attack: template.attack*level+r.rand(0..20),
	                                 defense: template.defense*level+r.rand(0..15),
	                                 vision: template.vision*level+r.rand(0..10),
	                                 state: "available"
	                                 )
	                                 
	  adventurer.hp=adventurer.max_hp
	  adventurer.energy = adventurer.max_energy
	  adventurer.guild = self
	  adventurer.save
	  return adventurer
	end

end

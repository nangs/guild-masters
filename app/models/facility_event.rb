class FacilityEvent < ActiveRecord::Base
	belongs_to :facility
	belongs_to :adventurer
	
	delegate :guild, to: :facility
  delegate :guildmaster, to: :facility

	def self.assign(facility,adventurers)
	  
	  if(adventurers.size>facility.capacity)
	    return {msg: :"error", detail: :"not_enough_space"}
	  end
	  if(facility.guild.guildmaster.state=="upgrading")
	    return {msg: :"error", detail: :"guildmaster_busy"}
	  end
	  total_gold_cost=0
	  for adv in adventurers
	    if(adv.state!="available")
	      return {msg: :"error", detail: :"adventurer_busy"}
	   
	    elsif(adv.hp==adv.max_hp&&facility.name=="clinic")
	      return {msg: :"error", detail: :"hp_is_full"}
	    elsif(adv.energy==adv.max_energy&&facility.name=="canteen")
	      return {msg: :"error", detail: :"energy_is_full"}
	    else
	      total_gold_cost=total_gold_cost+facility.gold_cost(adv)
	    end
	  end
    gm=facility.guildmaster
	  if(total_gold_cost>gm.gold)
	    return {msg: :"error", detail: :"not_enough_gold"}
	  end
	  
    gm.gold= gm.gold-total_gold_cost
	  msgArray = Array.new
	  for adv in adventurers
	    fe=FacilityEvent.new
	    
	    facility.facility_events << fe
	    facility.capacity=facility.capacity-1
      facility.save
      
	    adv.facility_events << fe
	    adv.state="resting"
	    adv.save
      
      fe.start_time = gm.game_time
      fe.end_time = gm.game_time+facility.time_cost(adv)
      fe.gold_spent = facility.gold_cost(adv)
	    fe.save
	    cost = {adventurer: adv, gold_cost: facility.gold_cost(adv)}
	    msgArray<<cost
	  end
	  
    gm.save
	  return {msg: :"success", detail: msgArray}
	end
	
	def complete
	  gm=self.guildmaster
	  fac=self.facility
	  adv=self.adventurer
	  
	  if(fac.name=="canteen")
	    msg = {msg: :"success", type: :"FacilityEvent", facility: :"canteen",adventurer: self.adventurer, energy_gain: adv.max_energy - adv.energy}
	    adv.energy=adv.max_energy
	    
	  else
	    msg = {msg: :"success",type: :"FacilityEvent", facility: :"clinic", adventurer: self.adventurer, hp_gain: adv.max_hp - adv.hp}
	    adv.hp = adv.max_hp
	  end
	  adv.state="available"
	  adv.save
	  fac.capacity=fac.capacity+1
	  fac.save
	  gm.game_time = self.end_time
	  gm.save
	  return msg
	end

end

class FacilityEvent < ActiveRecord::Base
	belongs_to :facility
	belongs_to :adventurer
	
	delegate :guild, to: :facility
  delegate :guildmaster, to: :facility

	def self.assign(facility,adventurers)
	  
	  if(adventurers.size>facility.capacity)
	    return msg = {msg: "error", detail: "not enough space in facility"}
	  end
	  total_gold_cost=0
	  for adv in adventurers
	    if(adv.state!="available")
	      return msg = {msg: "error", detail: "adventurer not available"}
	    elsif(adv.hp==adv.max_hp&&facility.name=="clinic")
	      return msg = {msg: "error", detail: "adventurer is already at full hp"}
	    elsif(adv.energy==adv.max_energy&&facility.name=="canteen")
	      return msg = {msg: "error", detail: "adventurer is already at full energy"}
	    end
	    total_gold_cost=total_gold_cost+facility.gold_cost(adv)
	  end
    gm=facility.guild.guildmaster
	  if(total_gold_cost>gm.gold)
	    return msg = {msg: "error", detail: "not enough gold"}
	  end
	  
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
	    gm.gold= gm.gold-total_gold_cost
	    gm.save
	  end
	  return msg = {msg:"success"}
	end

end

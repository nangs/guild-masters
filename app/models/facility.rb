class Facility < ActiveRecord::Base
	belongs_to :guild
	has_many :facility_events, dependent: :destroy

	delegate :guildmaster, to: :guild
	
	def time_cost(adv)
    if(self.name=="clinic")
      return 10+(adv.max_hp-adv.hp)/(1+self.level*0.25)
    else
      return 25+(adv.max_energy-adv.energy)/(1+self.level*0.25)   
    end    
  end
  
  def gold_cost(adv)
    if(self.name=="clinic")
      return 10+adv.max_hp-adv.hp
    else
      return 5+(adv.max_energy-adv.energy)*0.5   
    end    
  end
end
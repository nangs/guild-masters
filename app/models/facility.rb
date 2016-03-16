class Facility < ActiveRecord::Base
	belongs_to :guild
	has_many :facility_events, dependent: :destroy

	delegate :guildmaster, to: :guild
	
	def time_cost(adv)
    if(self.name=="clinic")
      return 10+(adv.max_hp-adv.hp)/(2+self.level)
    else
      return 25+(adv.max_energy-adv.energy)/(1+self.level/2)   
    end    
  end
  
  def gold_cost(adv)
    if(self.name=="clinic")
      return 10+(adv.max_hp-adv.hp)/5
    else
      return 5+(adv.max_energy-adv.energy)/2   
    end    
  end
end
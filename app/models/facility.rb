class Facility < ActiveRecord::Base
  belongs_to :guild
  has_many :facility_events, dependent: :destroy

  delegate :guildmaster, to: :guild

  def time_cost(adv)
    return 10 + (adv.max_hp - adv.hp) / (2 + level) if name == 'clinic'
    25 + (adv.max_energy - adv.energy) / (1 + level / 2)
  end

  def gold_cost(adv)
    return 10 + (adv.max_hp - adv.hp) / 5 if name == 'clinic'
    5 + (adv.max_energy - adv.energy) / 2
  end
end

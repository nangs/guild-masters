class Guildmaster < ActiveRecord::Base
  has_many :guilds, dependent: :destroy
  has_many :scout_events
  belongs_to :account

  # shortcuts to events
  has_many :scout_events, through: :guilds
  has_many :guild_upgrade_events, through: :guilds
  has_many :quests, through: :guilds
  has_many :quest_events, through: :quests
  has_many :facilities, through: :guilds
  has_many :facility_events, through: :facilities

  def build_guild
    guild = Guild.new
    guild.level = 1
    guild.popularity = 50
    guild.guildmaster = self
    clinic = Facility.new
    clinic.guild = guild
    clinic.name = 'clinic'
    clinic.level = 1
    clinic.capacity = 2
    clinic.save
    canteen = Facility.new
    canteen.guild = guild
    canteen.name = 'canteen'
    canteen.level = 1
    canteen.capacity = 2
    canteen.save
    guild.save
    guild
  end

  def refresh
    guilds = self.guilds
    msg_array = []
    guilds.each do |guild|
      advs = []
      qsts = []
      nqst = guild.popularity / (25 * (2**(guild.level - 1)))
      qst_c = 0
      nqst.times do
        if guild.qst_count < guild.level * 10
          qsts << guild.create_quest
          qst_c += 1
        end
      end
      nadv = guild.popularity / (50 * (2**(guild.level - 1)))
      adv_c = 0
      nadv.times do
        if guild.adv_count < guild.level * 5
          adv_c += 1
          advs << guild.create_adventurer
        end
      end
      msg = { guild: guild, new_quests: qsts, new_adventurers: advs, dropped_quests: nqst - qst_c, dropped_adventurers: nadv - adv_c }
      msg_array << msg
    end
    msg_array
  end
end

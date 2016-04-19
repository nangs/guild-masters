class ScoutEvent < ActiveRecord::Base
  belongs_to :guild
  delegate :guildmaster, to: :guild
  def self.assign(guild, time, gold)
    gm = guild.guildmaster
    return { msg: :error, detail: :guildmaster_busy } if gm.state != 'available'
    return { msg: :error, detail: :guild_full } if guild.full?
    return { msg: :error, detail: :not_enough_gold } if gm.gold < gold
    guild.scout_events.create(start_time: gm.game_time,
                              end_time: gm.game_time + time,
                              gold_spent: gold)
    gm.gold = gm.gold - gold
    gm.state = 'scouting'
    guild.save
    gm.save
    { msg: :success }
  end

  def complete
    r = Random.new
    time = end_time - start_time
    gold = gold_spent
    gm = guildmaster
    nadv = time / 300
    nadv = 3 if nadv >= 3
    nque = time / 200
    nque = 5 if nque >= 5
    advs = []
    qsts = []
    nadv.times do
      next unless guild.adv_count < guild.level * 5
      template = AdventurerTemplate.order('RANDOM()').first
      level = guild.level
      adventurer = Adventurer.create(
        name: Adventurer.random_adventurer_name,
        max_hp: template.max_hp * level + gold / 50 + r.rand(50..200),
        max_energy: 100 + level * 10 + gold / 200 + r.rand(0..10),
        attack: template.attack * level + gold / 100 + r.rand(0..10),
        defense: template.defense * level + gold / 100 + r.rand(0..10),
        vision: template.vision * level + gold / 200 + r.rand(0..10),
        state: 'available'
      )

      adventurer.hp = adventurer.max_hp
      adventurer.energy = adventurer.max_energy
      adventurer.save
      guild.adventurers << adventurer
      advs << adventurer
    end
    nque.times do
      next unless guild.qst_count < guild.level * 10
      r = Random.new
      quest = Quest.create(difficulty: guild.level + r.rand(0..1), state: 'pending')
      quest.reward = quest.difficulty * (100 + gold / 10) + r.rand(0..100)
      quest.monster_template = MonsterTemplate.order('RANDOM()').first
      description = QuestDescription.order('RANDOM()').first.description
      quest.description = description.sub('%s', quest.monster_template.name)
      quest.save
      guild.quests << quest
      qsts << quest
    end
    gm.game_time = end_time
    gm.state = 'available'
    gm.save
    { msg: :success, type: :ScoutEvent, adv_gain: advs.size, qst_gain: qsts.size, adventurers: advs, quests: qsts, adv_dropped: nadv - advs.size, qst_dropped: nque - qsts.size }
  end
end

class QuestEvent < ActiveRecord::Base
  belongs_to :quest
  has_and_belongs_to_many :adventurers
  accepts_nested_attributes_for :quest

  delegate :guild, to: :quest
  delegate :guildmaster, to: :quest

  def self.view_all
    events = QuestEvent.all
    events
  end

  # This function compute the result of quest, clearing the association and return message of result
  def complete
    # Relief adventurers and calculate quest factor
    result = quest.battle(adventurers)
    guild = self.guild
    gm = guildmaster
    # Success/Fail judgement
    if result[:result]
      quest.state = 'successful'
      guild.popularity = guild.popularity + quest.difficulty
      gm.gold = gm.gold + quest.reward
      msg = { msg: :success, type: :QuestEvent, gold_gain: quest.reward, popularity_gain: quest.difficulty, quest: quest, adventurers: adventurers, battle_log: result[:log] }
    else
      quest.state = 'failed'
      guild.popularity = guild.popularity - quest.difficulty
      msg = { msg: :failed, type: :QuestEvent, popularity_lost: quest.difficulty, quest: quest, adventurers: adventurers, battle_log: result[:log] }
    end
    for adv in adventurers
      guild.popularity = guild.popularity / 2 if adv.state == 'dead'
    end
    guild.save
    gm.game_time = end_time
    gm.save
    save
    msg
  end

  # This function will create the relationship between adventurer and quest_event and quest
  def self.assign(quest, adventurers)
    # Check Quest Status. Done by front end too
    if quest.state == 'assigned' || quest.state == 'successful'
      return { msg: :error, detail: :quest_not_available }
    end

    # Check Adventurers Status. Done by front end too
    adventurers.each do |adventurer|
      if adventurer.state == 'assigned' || adventurer.state == 'dead' || adventurer.energy <= 0
        return { msg: :error, detail: :adventurer_not_available }
      end
    end
    quest.state = 'assigned'

    # Generate new quest_event
    qe = QuestEvent.new
    adventurers.each do |adventurer|
      adventurer.state = 'assigned'
      adventurer.quest_events << qe
      adventurer.save
    end
    qe.quest = quest
    qe.start_time = quest.guild.guildmaster.game_time
    qe.end_time = qe.start_time + qe.time_cost
    qe.gold_spent = 0
    qe.save
    quest.quest_events << qe
    quest.save
    msg = { msg: :success }
    msg
  end

  # This function calculates the game time needed for the quest to complete
  def time_cost
    adv_vision = 0
    adventurers = self.adventurers
    for adventurer in adventurers
      adv_vision += adventurer.vision
    end
    mon_invis = quest.difficulty * quest.monster_template.invisibility
    turns = mon_invis.to_f / adv_vision.to_f
    for adventurer in adventurers
      adventurer.vision = adventurer.vision + turns.round * quest.difficulty
      adventurer.save
    end
    time = turns * 50.0
    100 * quest.difficulty + time.round
  end
end

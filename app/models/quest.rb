require 'monster.rb'

class Quest < ActiveRecord::Base
  belongs_to :guild
  has_many :quest_events
  belongs_to :monster_template

  delegate :guildmaster, to: :guild

  # This function returns a list of Quests to the controller
  def self.view_all
    quests = Quest.all
    quests
  end

  # This function simulates the battle process when carry out a quest
  def battle(adventurers)
    r = Random.new
    # Generate monster instance according to template
    advs = adventurers.clone
    survivers = (0..advs.size - 1).to_a
    attacks = Array.new(advs.size, 0)
    defenses = Array.new(advs.size, 0)
    monster = Monster.new(monster_template, difficulty)

    end_of_battle = false
    adv_victory = false
    turn = 0
    record = []
    until end_of_battle
      turn += 1
      dead = { dead: nil }
      advsPhase = []
      # Adventurers` phase
      for adv_id in survivers
        adventurer = adventurers[adv_id]
        if monster.hp > 0
          if adventurer.energy > 0
            dmg = r.rand(0.75..1.25) * adventurer.attack * adventurer.attack / monster.defense
            dmg = dmg.round
            monster.hp = monster.hp - dmg
            attacks[adv_id] = attacks[adv_id] + 1
            adventurer.energy = adventurer.energy - 2
            monster.hp = 0 if monster.hp < 0
          else
            adventurer.energy = 0
            dmg = 0
            survivers.delete(adv_id)
            end_of_battle = true if survivers.empty?
          end
        end
        advMsg = { adventurer_name: adventurer.name, adventurer_hp: adventurer.hp, dmg_deal: dmg, adventurer_energy: adventurer.energy }
        advsPhase << advMsg
      end
      # Monster`s phase
      if monster.hp > 0
        unless survivers.empty?
          target_id = survivers.sample
          target = advs[target_id]
          dmg = r.rand(0.75..1.25) * monster.attack * monster.attack / target.defense
          dmg = dmg.round
          target.hp = target.hp - dmg
          defenses[target_id] = defenses[target_id] + 1
          mstMsg = { monster_name: monster_template.name, monster_hp: monster.hp, target: target.name, dmg_deal: dmg }
          # Adventurer was killed
          if target.hp <= 0
            target.hp = 0
            target.energy = 0
            target.state = 'dead'
            dead = { dead: target.name }
            survivers.delete(target_id)
            end_of_battle = true if survivers.empty?
          end
        end
      elsif monster.hp == 0
        dead = { dead: monster_template.name }
        end_of_battle = true
        adv_victory = true
      end
      turnMsg = { turn: turn, adventurers: advsPhase, monsters: mstMsg, dead: dead }
      record << turnMsg
    end

    for adv_id in survivers
      adventurers[adv_id].attack = adventurers[adv_id].attack + attacks[adv_id] * difficulty + r.rand(0..5)
      adventurers[adv_id].defense = adventurers[adv_id].defense + defenses[adv_id] * difficulty + r.rand(0..5)
      adventurers[adv_id].max_hp = adventurers[adv_id].max_hp + defenses[adv_id] * difficulty * 5 + r.rand(0..25)
      adventurers[adv_id].max_energy = adventurers[adv_id].max_energy + difficulty + r.rand(0..5)
    end

    # Energy cost calculation
    for adventurer in advs
      adventurer.energy = adventurer.energy - 15 - r.rand(0..5)
      adventurer.state = 'available' if adventurer.state == 'assigned'
      adventurer.energy = 0 if adventurer.energy < 0
      adventurer.save
    end

    { result: adv_victory, log: record }
  end
end

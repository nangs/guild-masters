require 'facility_event.rb'
require 'quest_event.rb'
class Event < ActiveRecord::Base
  def self.complete_next(gm)
    qe=gm.quest_events.where("end_time > ?", gm.game_time).order("end_time").first
    fe= gm.facility_events.where("end_time > ?",gm.game_time).order("end_time").first
    se = gm.scout_events.where("end_time > ?", gm.game_time).order("end_time").first
    events =Array.new
    if(qe!=nil)
      events<<qe.end_time
    end
    if(fe!=nil)
      events<<fe.end_time
    end
    if(se!=nil)
      events<<se.end_time
    end
    end_time = events.min
    return Event.complete(gm,end_time)
  end
  
  def self.complete(gm,end_time)
    if(end_time<=gm.game_time)
      return {msg: :"error", detail: "Invalid end time"}
    end
    start_day = gm.game_time/1000
    qes=gm.quest_events.where(end_time: (gm.game_time+1)..end_time).order(:end_time)
    fes=gm.facility_events.where(end_time: (gm.game_time+1)..end_time).order(:end_time)
    ses=gm.scout_events.where(end_time: (gm.game_time+1)..end_time).order(:end_time)
    ges=gm.guild_upgrade_events.where(end_time: (gm.game_time+1)..end_time).order(:end_time)
    msgArray = Array.new
    for qe in qes
      msgArray<<qe.complete
    end
    for fe in fes
      msgArray<<fe.complete
    end
    for se in ses
      msgArray<<se.complete
    end
    for ge in ges
      msgArray<<ge.complete
    end
    day_dif = end_time/1000-start_day
    refreshArray = Array.new
    if(day_dif>0)
      day_dif.times do
        refreshArray<<gm.refresh
      end
    end
    gm.game_time = end_time
    gm.save
    return {events: msgArray, refresh: refreshArray}
  end
  
  def self.get_events(gm)
    @questEvents = gm.quest_events
    arrayOfAllEventsDetails = Array.new
    event_id = 1
    for @questEvent in @questEvents
      arrayOfAllEventsDetails << {
          event_id: event_id,
          type: :"QuestEvent",
          quest_event_id: @questEvent.id,
          start_time: @questEvent.start_time,
          end_time: @questEvent.end_time,
          quest: @questEvent.quest,
          adventurers: @questEvent.adventurers
      }
      event_id += 1
    end
    @facilityEvents = gm.facility_events
    for @facilityEvent in @facilityEvents
      arrayOfAllEventsDetails << {
          event_id: event_id,
          type: :"FacilityEvent",
          facility_event_id: @facilityEvent.id,
          start_time: @facilityEvent.start_time,
          end_time: @facilityEvent.end_time,
          facility: @facilityEvent.facility,
          adventurer: @facilityEvent.adventurer,
          gold_spent: @facilityEvent.gold_spent
      }
      event_id += 1
    end
    @scoutEvents = gm.scout_events
    for @scoutEvent in @scoutEvents
      arrayOfAllEventsDetails << {
          event_id: event_id,
          type: :"ScoutEvent",
          scout_event_id: @scoutEvent.id,
          start_time: @scoutEvent.start_time,
          end_time: @scoutEvent.end_time,
          gold_spent: @scoutEvent.gold_spent
      }
      event_id += 1
    end
    @upgradeEvents = gm.guild_upgrade_events
    for @upgradeEvent in @upgradeEvents
      arrayOfAllEventsDetails << {
          event_id: event_id,
          type: :"UpgradeEvent",
          upgrade_event_id: @upgradeEvent.id,
          start_time: @upgradeEvent.start_time,
          end_time: @upgradeEvent.end_time,
          gold_spent: @upgradeEvent.gold_spent,
          guild: @upgradeEvent.guild
      }
      event_id += 1
    end
    return arrayOfAllEventsDetails
  end
end

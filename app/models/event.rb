require 'facility_event.rb'
require 'quest_event.rb'
class Event < ActiveRecord::Base
  def self.complete_next(gm)
    qe = gm.quest_events.where('end_time > ?', gm.game_time).order('end_time').first
    fe = gm.facility_events.where('end_time > ?', gm.game_time).order('end_time').first
    se = gm.scout_events.where('end_time > ?', gm.game_time).order('end_time').first
    events = []
    events << qe.end_time unless qe.nil?
    events << fe.end_time unless fe.nil?
    events << se.end_time unless se.nil?
    end_time = events.min
    Event.complete(gm, end_time)
  end

  def self.complete(gm, end_time)
    if end_time <= gm.game_time
      return { msg: :error, detail: :invalid_end_time }
    end
    start_day = gm.game_time / 1000
    qes = gm.quest_events.where(end_time: (gm.game_time + 1)..end_time).order(:end_time)
    fes = gm.facility_events.where(end_time: (gm.game_time + 1)..end_time).order(:end_time)
    ses = gm.scout_events.where(end_time: (gm.game_time + 1)..end_time).order(:end_time)
    ges = gm.guild_upgrade_events.where(end_time: (gm.game_time + 1)..end_time).order(:end_time)
    msg_array = []
    for qe in qes
      msg_array << qe.complete
    end
    for fe in fes
      msg_array << fe.complete
    end
    for se in ses
      msg_array << se.complete
    end
    for ge in ges
      msg_array << ge.complete
    end
    day_dif = end_time / 1000 - start_day
    refresh_array = []
    if day_dif > 0
      day_dif.times do
        refresh_array << gm.refresh
      end
    end
    gm.game_time = end_time
    gm.save
    { events: msg_array, refresh: refresh_array }
  end

  def self.get_events(gm)
    @quest_events = gm.quest_events
    array_of_all_events_details = []
    event_id = 1
    for @quest_event in @quest_events
      array_of_all_events_details << {
        event_id: event_id,
        type: :QuestEvent,
        quest_event_id: @quest_event.id,
        start_time: @quest_event.start_time,
        end_time: @quest_event.end_time,
        quest: @quest_event.quest,
        adventurers: @quest_event.adventurers
      }
      event_id += 1
    end
    @facility_events = gm.facility_events
    for @facility_event in @facility_events
      array_of_all_events_details << {
        event_id: event_id,
        type: :FacilityEvent,
        facility_event_id: @facility_event.id,
        start_time: @facility_event.start_time,
        end_time: @facility_event.end_time,
        facility: @facility_event.facility,
        adventurer: @facility_event.adventurer,
        gold_spent: @facility_event.gold_spent
      }
      event_id += 1
    end
    @scout_events = gm.scout_events
    for @scout_event in @scout_events
      array_of_all_events_details << {
        event_id: event_id,
        type: :ScoutEvent,
        scout_event_id: @scout_event.id,
        start_time: @scout_event.start_time,
        end_time: @scout_event.end_time,
        gold_spent: @scout_event.gold_spent
      }
      event_id += 1
    end
    @upgrade_events = gm.guild_upgrade_events
    for @upgrade_event in @upgrade_events
      array_of_all_events_details << {
        event_id: event_id,
        type: :UpgradeEvent,
        upgrade_event_id: @upgrade_event.id,
        start_time: @upgrade_event.start_time,
        end_time: @upgrade_event.end_time,
        gold_spent: @upgrade_event.gold_spent,
        guild: @upgrade_event.guild
      }
      event_id += 1
    end
    array_of_all_events_details
  end
end

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
    qes.each do |qe|
      msg_array << qe.complete
    end
    fes.each do |fe|
      msg_array << fe.complete
    end
    ses.each do |se|
      msg_array << se.complete
    end
    ges.each do |ge|
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
    @quest_events.each do |qe|
      array_of_all_events_details << {
        event_id: event_id,
        type: :QuestEvent,
        quest_event_id: qe.id,
        start_time: qe.start_time,
        end_time: qe.end_time,
        quest: qe.quest,
        adventurers: qe.adventurers
      }
      event_id += 1
    end
    @facility_events = gm.facility_events
    @facility_events.each do |fe|
      array_of_all_events_details << {
        event_id: event_id,
        type: :FacilityEvent,
        facility_event_id: fe.id,
        start_time: fe.start_time,
        end_time: fe.end_time,
        facility: fe.facility,
        adventurer: fe.adventurer,
        gold_spent: fe.gold_spent
      }
      event_id += 1
    end
    @scout_events = gm.scout_events
    @scout_events.each do |se|
      array_of_all_events_details << {
        event_id: event_id,
        type: :ScoutEvent,
        scout_event_id: se.id,
        start_time: se.start_time,
        end_time: se.end_time,
        gold_spent: se.gold_spent
      }
      event_id += 1
    end
    @upgrade_events = gm.guild_upgrade_events
    @upgrade_events.each do |ue|
      array_of_all_events_details << {
        event_id: event_id,
        type: :UpgradeEvent,
        upgrade_event_id: ue.id,
        start_time: ue.start_time,
        end_time: ue.end_time,
        gold_spent: ue.gold_spent,
        guild: ue.guild
      }
      event_id += 1
    end
    array_of_all_events_details
  end
end

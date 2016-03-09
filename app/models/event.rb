require 'facility_event.rb'
require 'quest_event.rb'
class Event < ActiveRecord::Base
  def self.complete_next(gm)
    qe=gm.quest_events.where("end_time > ?", gm.game_time).first
    fe= gm.facility_events.where("end_time > ?",gm.game_time).first
    if(qe!=nil&&fe==nil)
      end_time = qe.end_time
    elsif(fe!=nil&&qe==nil)
      end_time=fe.end_time
    else
      if(qe.end_time<fe.end_time)
        end_time = qe.end_time
      else
        end_time = fe.end_time
      end
    end 
    return Event.complete(gm,end_time)
  end
  
  def self.complete(gm,end_time)
    qes=gm.quest_events.where(end_time: (gm.game_time+1)..end_time).order(:end_time)
    fes=gm.facility_events.where(end_time: (gm.game_time+1)..end_time).order(:end_time)
    msgArray = Array.new
    for qe in qes
      msgArray<<qe.complete
    end
    for fe in fes
      msgArray<<fe.complete
    end
    return msgArray
  end
  
  def self.get_events(gm)
    @questEvents = gm.quest_events
    arrayOfAllEventsDetails = Array.new
    event_id = 1
    for @questEvent in @questEvents
      arrayOfAllEventsDetails << {
          event_id: event_id,
          type: "QuestEvent",
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
          type: "FacilityEvent",
          facility_event_id: @facilityEvent.id,
          start_time: @facilityEvent.start_time,
          end_time: @facilityEvent.end_time,
          facility: @facilityEvent.facility,
          adventurer: @facilityEvent.adventurer
      }
      event_id += 1
      return arrayOfAllEventsDetails
    end
  end
end

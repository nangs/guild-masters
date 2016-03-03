require 'facility_event.rb'
require 'quest_event.rb'
class Event < ActiveRecord::Base
  def self.complete_next(gm)
    end_time=gm.quest_events.where("end_time > ?", gm.game_time).first.end_time
    temp = gm.facility_events.where("end_time > ?",gm.game_time).first.end_time
    end_time = temp if temp < end_time
    return Event.complete(gm,end_time)
  end
  
  def self.complete(gm,end_time)
    qes=gm.quest_events.where(end_time: gm.game_time..end_time)
    fes=gm.facility_events.where(end_time: gm.game_time..end_time)
    for qe in qes
      qe.complete
    end
    for fe in fes
      fe.complete
    end
    gm.game_time=end_time
    gm.save
    return {msg: "successful"}
  end
end

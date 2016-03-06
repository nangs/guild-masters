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
    for qe in qes
      qe.complete
    end
    for fe in fes
      fe.complete
    end
    return {msg: "successful"}
  end
end

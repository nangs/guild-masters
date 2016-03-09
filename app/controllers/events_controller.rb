class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

# GET /events.json
  def index
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster

    @questEvents = guildmaster.quest_events
    arrayOfAllEventsDetails = Array.new
    event_id = 1
    for @questEvent in @questEvents
      arrayOfAllEventsDetails << {
          event_id: event_id,
          type: "QuestEvent",
          quest_event_id: @questEvent.id,
          start_time: @questEvent.start_time,
          end_time: @questEvent.end_time,
          quest: @questEvent.quest( except: :created_at),
          adventurers: @questEvent.adventurers
      }
      event_id += 1
    end
    @facilityEvents = guildmaster.facility_events
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
    end
    respond_to do |format|
      format.json { render json: arrayOfAllEventsDetails.to_json(except: [:updated_at, :created_at])}
    end
  end

  # POST /events.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    if params[:cmd] == "complete_next"
      @result_complete_next_event = Event.complete_next(guildmaster)
      respond_to do |format|
        format.json { render json: @result_complete_next_event}
      end
    elsif params[:cmd] == "complete"
      @result_complete_event = Event.complete(guildmaster,params[:end_time])
      respond_to do |format|
        format.json { render json: @result_complete_event}
      end
    end
  end
end
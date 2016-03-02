class EventsController < ApplicationController
# GET /events.json
  def index
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster

    @questEvents = guildmaster.quest_events
    msg = Array.new
    event_id = 1
    for @questEvent in @questEvents
      msg << {
          type: "QuestEvent",
          event_id: event_id,
          start_time: @questEvent.start_time,
          end_time: @questEvent.end_time,
          quest: @questEvent.quest,
          adventurers: @questEvent.adventurers
      }
      event_id += 1
    end
    # @facilityEvents = guildmaster.facility_events
    # for @facilityEvent in @facilityEvents
    #   msg << {
    #       type: "FacilityEvent",
    #       event_id: event_id,
    #       start_time: @facilityEvent.start_time,
    #       end_time: @facilityEvent.end_time,
    #       facility: @facilityEvent.facility,
    #       adventurers: @facilityEvent.adventurers
    #   }
    #   event_id += 1
    # end
    respond_to do |format|
      format.json { render json: msg}
    end
  end

  # POST /events.json
  def create
    if params[:cmd] == 'complete'
      eventId = params[:eventId]
      @questEvent = QuestEvent.complete(eventId)
      respond_to do |format|
        format.json { render json: @questEvent.to_json}
      end
    end
  end

  def update
  end

  def destroy
  end

end
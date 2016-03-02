class EventsController < ApplicationController
# GET /events.json
  def index
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster

    @questEvents = guildmaster.quest_events
    msg = Array.new
    for @questEvent in @questEvents
      msg << {
          type: "QuestEvent",
          startTime: @questEvent.start_time,
          endTime: @questEvent.end_time,
          adventurers: @questEvent.adventurers,
          quest: @questEvent.quest
      }
    end
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
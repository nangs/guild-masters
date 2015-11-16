class EventsController < ApplicationController
# GET /events.json
  def index
    @questEvents = QuestEvent.view_all
    respond_to do |format|
      format.json { render json: @questEvents }
    end
  end

  # POST /events.json
  def create
    if params[:cmd] == "complete"
      questId = params[:questId]
      @questEvent = QuestEvent.complete(questId)
      respond_to do |format|
        format.json { render json: @questEvent }
      end
    end
  end

  def update
  end

  def destroy
  end

end
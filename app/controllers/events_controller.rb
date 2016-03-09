class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

# GET /events.json
  def index
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    @result = Event.get_events(guildmaster)
    render json: @result.as_json(except: [:updated_at, :created_at])
  end

  # POST /events.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    if params[:cmd] == "complete_next"
      @result_complete_next_event = Event.complete_next(guildmaster)
      render json: @result_complete_next_event.as_json(except: [:updated_at, :created_at])
    elsif params[:cmd] == "complete"
      @result_complete_event = Event.complete(guildmaster,params[:end_time])
      render json: @result_complete_event.as_json(except: [:updated_at, :created_at])
    end
  end
end
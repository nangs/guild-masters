class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize
  respond_to :json

  # POST /events.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    if params[:cmd] == "complete_next"
      @result_complete_next_event = Event.complete_next(guildmaster)
      render json: @result_complete_next_event.as_json(except: [:updated_at, :created_at])
    elsif params[:cmd] == "complete"
      @end_time = params[:end_time].chomp.to_i
      if !@end_time.nil?
        @result_complete_event = Event.complete(guildmaster,@end_time)
        render json: @result_complete_event.as_json(except: [:updated_at, :created_at])
      elsif @end_time.nil?
        render json: {msg: :"error", detail: :"end_time_nil"}
      end
    elsif params[:cmd] == "get"
      @result = Event.get_events(guildmaster)
      render json: @result.as_json(except: [:updated_at, :created_at])
    elsif params[:cmd] == "create_guild_upgrade_event"
      @result_guild_upgrade_event = Guild.upgrade
      render json: @result_guild_upgrade_event.as_json(except: [:updated_at, :created_at])
    end
  end
end
class ScoutEventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  # GET /scout_events.json
  def index

  end


  # POST /scout_events.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
    @result_assign_scout = ScoutEvent.assign(guild,params[:time_spent],params[:gold_spent])
    render json: @result_assign_scout.as_json(except: [:updated_at, :created_at])
  end
end
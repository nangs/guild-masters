class ScoutEventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json
  before_action :authorize
  
  # POST /scout_events.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
    @time_spent = params[:time_spent]
    @gold_spent = params[:gold_spent]
    if !@time_spent.nil? && !@gold_spent.nil?
      @result_assign_scout = ScoutEvent.assign(guild,@time_spent,@gold_spent)
      render json: @result_assign_scout.as_json(except: [:updated_at, :created_at])
    elsif @time_spent.nil?
      render json: {msg: :"error", detail: :"invalid_time"}
    elsif @gold_spent.nil?
      render json: {msg: :"error", detail: :"invalid_gold"}
    end
  end
end
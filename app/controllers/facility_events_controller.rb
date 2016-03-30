class FacilityEventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize
  respond_to :json

  # POST /facility_events.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
    if params[:cmd] == "get"
      @facility_events = guild.facility_events
      render json: @facility_events.as_json(except: [:updated_at, :created_at])
    elsif params[:cmd] == "create"
      @facility = guild.facilities.find_by(id: params[:facility_id])
      if params[:adventurers_ids].nil?
        @result_assign_facility = {msg: :"error", detail: :"no_adventurers_selected"}
      elsif !params[:adventurers_ids].nil?
        adventurers = Adventurer.find(params[:adventurers_ids])
        @result_assign_facility = FacilityEvent.assign(@facility,adventurers)
      end
      render json: @result_assign_facility.as_json(except: [:updated_at, :created_at])
    end
  end
end
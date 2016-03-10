class FacilityeventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  # GET /facilityevents.json
  def index
    acc = Account.find(session[:account_id])
    @guildmaster = acc.guildmaster
    @guild = Guild.find(@guildmaster.current_guild_id)
    @facilityevents = @guild.facility_events
    render json: @facilityevents.as_json(except: [:updated_at, :created_at])
  end
  ########
  ########for testing not for release
  ########

  # POST /facilityevents.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
    @facility = guild.facilities.find_by(id: params[:facility_id])
    adventurers = Adventurer.find(params[:adventurers_ids])
    if adventurers.nil?
      @result_assign_facility = {msg: :"error", detail: :"no_adventurers_selected"}
    elsif !adventurers.nil?
      @result_assign_facility = FacilityEvent.assign(@facility,adventurers)
    end
    render json: @result_assign_facility.as_json(except: [:updated_at, :created_at])
  end
end
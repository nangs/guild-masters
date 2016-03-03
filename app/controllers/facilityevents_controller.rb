class FacilityeventsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /facilityevents.json
  def index
    acc = Account.find(session[:account_id])
    @guildmaster = acc.guildmaster
    @guild = Guild.find(@guildmaster.current_guild_id)
    @facilityevents = @guild.facility_events
    respond_to do |format|
      format.json { render json: @facilityevents }
    end
  end
  ########
  ########for testing not for release
  ########

  # POST /facilityevents.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
    @facility = guild.facilities.find_by(name: params[:facility_id])
    adventurers = Adventurer.find(params[:adventurers_ids])
    assign_facility = FacilityEvent.assign(@facility,adventurers)
    respond_to do |format|
      format.json { render json: assign_facility }
    end
  end
end
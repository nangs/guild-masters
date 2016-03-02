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
    if params[:cmd] == 'assign'
      @facility = guild.facilities.find_by(name: params[:facility_name])
      adventurers = Adventurer.find(params[:adventurers_ids])
      assign_facility = FacilityEvent.assign(@facility,adventurers)
      respond_to do |format|
        format.json { render json: assign_facility }
      end
    elsif params[:cmd] == 'complete'
      @facilityEvent = guildmaster.facility_events.find_by(id: params[:facility_event_id])
      # complete_facility = FacilityEvent.complete
      # respond_to do |format|
      #   format.json { render json: complete_facility }
      # end
    end
  end
end
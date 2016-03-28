class FacilitiesController < ApplicationController
  respond_to :json
  before_action :authorize

  # GET /facilities.json
  def index
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
    facilities = guild.facilities
    respond_to do |format|
      format.json { render json: facilities }
    end
  end
  ########
  ########for testing not for release
  ########
end
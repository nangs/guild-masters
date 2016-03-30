class FacilitiesController < ApplicationController
  respond_to :json
  before_action :authorize

  # POST /facilities.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
    if params[:cmd] == "get"
      facilities = guild.facilities
      render json: facilities.as_json(:except => [:created_at, :updated_at])
    end
  end
end
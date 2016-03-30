class AdventurersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize
  respond_to :json

  # POST /adventurers.json
  # Call this to get adventurers
  def create
    if params[:cmd] == "get"
      acc = Account.find(session[:account_id])
      guildmaster = acc.guildmaster
      guild = Guild.find(guildmaster.current_guild_id)
      adventurers = guild.adventurers
      render json: adventurers.as_json(:except => [:created_at, :updated_at])
    end
  end
end

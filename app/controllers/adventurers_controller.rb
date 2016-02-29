class AdventurersController < ApplicationController
  skip_before_action :verify_authenticity_token

  ########
  ########for testing not for release
  ########
# GET /adventurers.json
  def index
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
    adventurers = guild.adventurers
    respond_to do |format|
      format.json { render json: adventurers }
    end
  end
  ########
  ########for testing not for release
  ########

  # POST /adventurers.json
  # Call this to create adventurers
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
    new_adventurer = guild.create_adventurer
    respond_to do |format|
      format.json { render json: new_adventurer }
    end
  end
end

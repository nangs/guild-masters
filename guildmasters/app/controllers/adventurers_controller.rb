class AdventurersController < ApplicationController
  skip_before_action :verify_authenticity_token

  ########
  ########for testing not for release
  ########
# GET /adventurers.json
  def index
    guild = Guild.find(session[:guild])
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
    guild = Guild.find(session[:guild])
    return guild.create_adventurer
  end
end

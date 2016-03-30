class AdventurersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize
  respond_to :json

  ########
  ########for testing not for release
  ########
# GET /adventurers.json
  def index
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
    adventurers = guild.adventurers
    render json: adventurers.as_json(:except => [:created_at, :updated_at])
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
    render json: new_adventurer.as_json(:except => [:created_at, :updated_at])
  end
end

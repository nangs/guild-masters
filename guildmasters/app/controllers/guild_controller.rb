class GuildController < ApplicationController
  ########
  ########for testing not for release
  ########
  # GET /guilds.json
  def index
    guild = Guild.find(session[:guild_id])
    respond_to do |format|
      format.json { render json: guild }
    end
  end
  ########
  ########for testing not for release
  ########

  # POST /guilds.json
  def create
    guildmaster.build_guild
  end

end


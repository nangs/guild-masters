class GuildController < ApplicationController
  respond_to :json
  before_action :authorize

  ########
  ########for testing not for release
  ########
  # GET /guild.json
  def index
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
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


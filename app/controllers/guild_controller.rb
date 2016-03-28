class GuildController < ApplicationController
  respond_to :json
  before_action :authorize

  # ########
  # ########for testing not for release
  # ########
  # # GET /guild.json
  # def index
  #   acc = Account.find(session[:account_id])
  #   guildmaster = acc.guildmaster
  #   guild = Guild.find(guildmaster.current_guild_id)
  #   render json: guild
  # end
  # ########
  # ########for testing not for release
  # ########

  # POST /guilds.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    if guildmaster.build_guild
      result = {msg: :"success"}
    else
      result = {msg: :"error", detail: :"cannot_build_guild"}
    end
    render json: result.as_json
  end

end


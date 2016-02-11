class GuildController < ApplicationController
  ########
  ########for testing not for release
  ########
  # GET /guild.json
  def index
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guilds = guildmaster.guilds
    respond_to do |format|
      format.json { render json: guilds }
    end
  end
  ########
  ########for testing not for release
  ########

end


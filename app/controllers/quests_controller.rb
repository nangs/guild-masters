class QuestsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

# GET /quests.json
  def index
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
    quests = guild.quests
    respond_to do |format|
      format.json { render json: quests }
    end
  end

# POST /quests.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
    if params[:cmd] == "generate"
      quest = guild.create_quest
      respond_to do |format|
        format.json { render json: quest }
      end
    end
  end
end

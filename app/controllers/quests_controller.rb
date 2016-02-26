class QuestsController < ApplicationController
  skip_before_action :verify_authenticity_token
# GET /quests
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
    if params[:cmd] == 'generate'
      quest = guild.create_quest
      respond_to do |format|
        format.json { render json: quest }
      end
    elsif params[:cmd] == 'assign'
      quest = guild.quests.find(params[:quest_id])
      adventurers = Adventurer.find(params[:adventurers_ids])
      assign_quest = QuestEvent.assign(quest,adventurers)
      respond_to do |format|
        format.json { render json: assign_quest }
      end
    elsif params[:cmd] == 'complete'
      complete_quest = QuestEvent.complete
      respond_to do |format|
        format.json { render json: complete_quest }
      end
    end
  end
end

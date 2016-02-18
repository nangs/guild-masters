class QuestsController < ApplicationController
  skip_before_action :verify_authenticity_token
# GET /quests
# GET /quests.json
  def index
    guild = Guild.find(session[:guild_id])
    quests = guild.quests
    respond_to do |format|
      format.json { render json: quests }
    end
  end

# POST /quests.json
  def create
    if params[:cmd] == 'generate'
      guild = Guild.find(session[:guild_id])
      quest = guild.create_quest
      respond_to do |format|
        format.json { render json: quest }
      end
    elsif params[:cmd] == 'assign'
      quest = Quest.find(params[:quest_id])
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

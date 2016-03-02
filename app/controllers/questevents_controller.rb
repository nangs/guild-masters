class QuesteventsController < ApplicationController
  # GET /questevents.json
  def index
    acc = Account.find(session[:account_id])
    @guildmaster = acc.guildmaster
    @guild = Guild.find(@guildmaster.current_guild_id)
    @questevents = @guild.questevents
    respond_to do |format|
      format.json { render json: @questevents }
    end
  end
  ########
  ########for testing not for release
  ########

  # POST /questevents.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
    if params[:cmd] == 'assign'
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
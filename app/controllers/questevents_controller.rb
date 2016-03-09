class QuesteventsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /questevents.json
  def index
    acc = Account.find(session[:account_id])
    @guildmaster = acc.guildmaster
    @guild = Guild.find(@guildmaster.current_guild_id)
    @questevents = @guild.quest_events
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
    quest = guild.quests.find(params[:quest_id])
    adventurers = Adventurer.find(params[:adventurers_ids])
    assign_quest = QuestEvent.assign(quest,adventurers)
    respond_to do |format|
      format.json { render json: assign_quest }
    end
  end
end
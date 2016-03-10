class QuesteventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  # GET /questevents.json
  def index
    acc = Account.find(session[:account_id])
    @guildmaster = acc.guildmaster
    @guild = Guild.find(@guildmaster.current_guild_id)
    @questevents = @guild.quest_events
    render json: @questevents.as_json(except: [:updated_at, :created_at])
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
    if adventurers.nil?
      @result_assign_quest = {msg: :"error", detail: :"no_adventurers_selected"}
    elsif !adventurers.nil?
      @result_assign_quest = QuestEvent.assign(quest,adventurers)
    end
    render json: @result_assign_quest.as_json(except: [:updated_at, :created_at])
  end
end
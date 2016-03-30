class QuestEventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json
  before_action :authorize

  # POST /quest_events.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
    if params[:cmd] == "get"
      result = guild.quest_events
      render json: result.as_json(except: [:updated_at, :created_at])
    elsif params[:cmd] == "create"
      quest = guild.quests.find(params[:quest_id])
      if params[:adventurers_ids].nil?
        @result_assign_quest = {msg: :"error", detail: :"no_adventurers_selected"}
      elsif !params[:adventurers_ids].nil?
        adventurers = Adventurer.find(params[:adventurers_ids])
        @result_assign_quest = QuestEvent.assign(quest,adventurers)
      end
      render json: @result_assign_quest.as_json(except: [:updated_at, :created_at])
    end
  end
end
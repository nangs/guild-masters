class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize
  respond_to :json

  # POST /events.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
    if params[:cmd] == "complete_next"
      @result_complete_next_event = Event.complete_next(guildmaster)
      render json: @result_complete_next_event.as_json(except: [:updated_at, :created_at])
    elsif params[:cmd] == "complete"
      @end_time = params[:end_time].chomp.to_i
      if !@end_time.nil?
        @result_complete_event = Event.complete(guildmaster,@end_time)
        render json: @result_complete_event.as_json(except: [:updated_at, :created_at])
      elsif @end_time.nil?
        render json: {msg: :"error", detail: :"end_time_nil"}
      end
    elsif params[:cmd] == "get"
      @result = Event.get_events(guildmaster)
      render json: @result.as_json(except: [:updated_at, :created_at])
    elsif params[:cmd] == "create_guild_upgrade_event"
      @result_guild_upgrade_event = Guild.find_by(id: guildmaster.current_guild_id).upgrade
      render json: @result_guild_upgrade_event.as_json(except: [:updated_at, :created_at])
    elsif params[:cmd] == "create_quest_event"
      quest = guild.quests.find(params[:quest_id])
      if params[:adventurers_ids].nil?
        @result_assign_quest = {msg: :"error", detail: :"no_adventurers_selected"}
      elsif !params[:adventurers_ids].nil?
        adventurers = Adventurer.find(params[:adventurers_ids])
        @result_assign_quest = QuestEvent.assign(quest,adventurers)
      end
      render json: @result_assign_quest.as_json(except: [:updated_at, :created_at])
    elsif params[:cmd] == "create_scout_event"
      @time_spent = params[:time_spent].chomp.to_i
      @gold_spent = params[:gold_spent].chomp.to_i
      if !@time_spent.nil? && !@gold_spent.nil?
        @result_assign_scout = ScoutEvent.assign(guild,@time_spent,@gold_spent)
        render json: @result_assign_scout.as_json(except: [:updated_at, :created_at])
      elsif @time_spent.nil?
        render json: {msg: :"error", detail: :"invalid_time"}
      elsif @gold_spent.nil?
        render json: {msg: :"error", detail: :"invalid_gold"}
      end
    elsif params[:cmd] == "create_facility_event"
      @facility = guild.facilities.find_by(id: params[:facility_id])
      if params[:adventurers_ids].nil?
        @result_assign_facility = {msg: :"error", detail: :"no_adventurers_selected"}
      elsif !params[:adventurers_ids].nil?
        adventurers = Adventurer.find(params[:adventurers_ids])
        @result_assign_facility = FacilityEvent.assign(@facility,adventurers)
      end
      render json: @result_assign_facility.as_json(except: [:updated_at, :created_at])
    end
  end
end
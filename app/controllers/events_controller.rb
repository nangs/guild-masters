class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize
  respond_to :json

  # POST /events.json
  def create
    acc = Account.find_by(id: session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find_by(id: guildmaster.current_guild_id)
    if !guild.nil?
      if params[:cmd] == "get"
        result = Event.get_events(guildmaster)

      elsif params[:cmd] == "complete"
        end_time = params[:end_time]
        if !end_time.nil?
          result = Event.complete(guildmaster, end_time.chomp.to_i)
        elsif end_time.nil?
          result = {msg: :"error", detail: :"end_time_nil"}
        end

      elsif params[:cmd] == "create_guild_upgrade_event"
        result = Guild.find_by(id: guildmaster.current_guild_id).upgrade

      elsif params[:cmd] == "create_quest_event"
        quest_id = params[:quest_id]
        adventurers_ids = params[:adventurers_ids]
        if !quest_id.nil?
          quest = guild.quests.find_by(id: quest_id.chomp.to_i)
          if !quest.nil?
            if adventurers_ids.nil?
              result = {msg: :"error", detail: :"no_adventurers_selected"}
            elsif !adventurers_ids.nil?
              adventurers = Adventurer.find_by(id: adventurers_ids)
              if !adventurers.nil?
                result = QuestEvent.assign(quest, adventurers)
              elsif adventurers.nil?
                result = {msg: :"error", detail: :"invalid_adventurers_ids"}
              end
            end
          elsif quest.nil?
            result = {msg: :"error", detail: :"invalid_quest_id"}
          end
        elsif quest_id.nil
          result = {msg: :"error", detail: :"quest_id_nil"}
        end

      elsif params[:cmd] == "create_scout_event"
        time_spent = params[:time_spent].chomp.to_i
        gold_spent = params[:gold_spent].chomp.to_i
        if !time_spent.nil? && !gold_spent.nil?
          result = ScoutEvent.assign(guild, time_spent, gold_spent)
        elsif time_spent.nil?
          result = {msg: :"error", detail: :"invalid_time"}
        elsif gold_spent.nil?
          result = {msg: :"error", detail: :"invalid_gold"}
        end

      elsif params[:cmd] == "create_facility_event"
        facility = guild.facilities.find_by(id: params[:facility_id])
        if params[:adventurers_ids].nil?
          result = {msg: :"error", detail: :"no_adventurers_selected"}
        elsif !params[:adventurers_ids].nil?
          adventurers = Adventurer.find(params[:adventurers_ids])
          result = FacilityEvent.assign(facility, adventurers)
        end

      elsif params[:cmd].nil?
        result = {msg: :"error", detail: :"cmd_nil"}
      else
        result = {msg: :"error", detail: :"no_such_cmd"}
      end
    elsif guild.nil?
      result = {msg: :"error", detail: :"guild_session_not_found"}
    end
    render json: result.as_json(except: [:updated_at, :created_at])
  end
end
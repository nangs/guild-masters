# This class controller handles retrieving of events, creation of events, completion of events
# with appropriate references to the database
class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize
  respond_to :json

  # POST /events.json
  # Pre-condition: all required params cannot be nil, must be signed in
  # possible cmd: get, complete, create_guild_upgrade_event, create_quest_event, create_scout_event, create_facility_event
  #
  # ----- get --
  # Pre-condition: signed in
  # returns json format {events: array_of_events}
  #
  # ----- complete --
  # Pre-condition: must be signed in, end_time
  # returns json format {events: msgArray, refresh: refreshArray}
  #
  # ----- create_guild_upgrade_event --
  # Pre-condition: must be signed in, email, password, confirm_token
  # returns json format {msg: :success, gold_spent: somevalue, time_cost: somevalue}
  #
  # ----- create_quest_event --
  # Pre-condition: must be signed in, quest_id,adventurers_ids
  # returns json format {msg: :success}
  #
  # ----- create_scout_event --
  # Pre-condition: must be signed in, time_spent,gold_spent
  # returns json format {msg: :success}
  #
  # ----- create_facility_event --
  # Pre-condition: must be signed in, facility_id,adventurers_ids
  # returns json format {msg: :success, detail: msgArray}
  def create
    acc = Account.find_by(id: session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find_by(id: guildmaster.current_guild_id)
    if !guild.nil?
      if params[:cmd] == 'get'
        result = Event.get_events(guildmaster)

      elsif params[:cmd] == 'complete'
        end_time = params[:end_time]
        if !end_time.nil?
          result = Event.complete(guildmaster, end_time.chomp.to_i)
        elsif end_time.nil?
          result = { msg: :error, detail: :end_time_nil }
        end

      elsif params[:cmd] == 'create_guild_upgrade_event'
        result = Guild.find_by(id: guildmaster.current_guild_id).upgrade

      elsif params[:cmd] == 'create_quest_event'
        quest_id = params[:quest_id]
        adventurers_ids = params[:adventurers_ids]
        if !quest_id.nil?
          quest = guild.quests.find_by(id: quest_id)
          if !quest.nil?
            if adventurers_ids.nil?
              result = { msg: :error, detail: :adventurers_ids_nil }
            elsif !adventurers_ids.nil?
              begin
                adventurers = Adventurer.find(adventurers_ids)
                result = QuestEvent.assign(quest, adventurers)
              rescue ActiveRecord::RecordNotFound
                result = { msg: :error, detail: :invalid_adventurers_ids }
              end
            end
          elsif quest.nil?
            result = { msg: :error, detail: :invalid_quest_id }
          end
        elsif quest_id.nil?
          result = { msg: :error, detail: :quest_id_nil }
        end

      elsif params[:cmd] == 'create_scout_event'
        time_spent = params[:time_spent]
        gold_spent = params[:gold_spent]
        if !time_spent.nil? && !gold_spent.nil?
          result = ScoutEvent.assign(guild, time_spent.chomp.to_i, gold_spent.chomp.to_i)
        elsif time_spent.nil?
          result = { msg: :error, detail: :time_nil }
        elsif gold_spent.nil?
          result = { msg: :error, detail: :gold_nil }
        end

      elsif params[:cmd] == 'create_facility_event'
        facility_id = params[:facility_id]
        adventurers_ids = params[:adventurers_ids]
        if !facility_id.nil?
          facility = guild.facilities.find_by(id: facility_id)
          if !facility.nil?
            if adventurers_ids.nil?
              result = { msg: :error, detail: :adventurers_ids_nil }
            elsif !adventurers_ids.nil?
              begin
                adventurers = Adventurer.find(adventurers_ids)
                result = FacilityEvent.assign(facility, adventurers)
              rescue ActiveRecord::RecordNotFound
                result = { msg: :error, detail: :invalid_adventurers_ids }
              end
            end
          elsif facility.nil?
            result = { msg: :error, detail: :invalid_facility_id }
          end
        elsif facility_id.nil?
          result = { msg: :error, detail: :facility_id_nil }
        end

      elsif params[:cmd].nil?
        result = { msg: :error, detail: :cmd_nil }
      else
        result = { msg: :error, detail: :no_such_cmd }
      end
    elsif guild.nil?
      result = { msg: :error, detail: :guild_session_not_found }
    end
    render json: result.as_json(except: [:updated_at, :created_at])
  end
end

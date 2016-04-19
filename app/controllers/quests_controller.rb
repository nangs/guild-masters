# This class controller handles retrieving of quest objects with appropriate references to the database
class QuestsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json
  before_action :authorize

  # POST /quests.json
  # possible cmd: get
  #
  # ----- get --
  # Pre-condition: signed in
  # gets quests
  # returns json format {msg: success, quests: guild.quests}
  #
  def create
    acc = Account.find_by(id: session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find_by(id: guildmaster.current_guild_id)
    if !guild.nil?
      result = if params[:cmd] == 'get'
                 { msg: 'success', quests: guild.quests }
               elsif params[:cmd].nil?
                 { msg: :error, detail: :cmd_nil }
               else
                 { msg: :error, detail: :no_such_cmd }
               end
    elsif guild.nil?
      result = { msg: :error, detail: :guild_session_not_found }
    end
    render json: result.as_json(except: [:created_at, :updated_at])
  end
end

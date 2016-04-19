class GuildController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token
  before_action :authorize

  # POST /guilds.json
  # possible cmd: get, create
  #
  # ----- get --
  # Pre-condition: signed in
  # returns json format {msg: :success, guild: guild.get_info}
  #
  # ----- create --
  # Pre-condition: signed in
  # returns json format {msg: :success}
  #
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    if params[:cmd] == 'get'
      guild = Guild.find_by(id: guildmaster.current_guild_id)
      if guild.nil?
        result = { msg: :error, detail: :guild_session_not_found }
      elsif !guild.nil?
        result = { msg: :success, guild: guild.info }
      end
    elsif params[:cmd] == 'create'
      guildmaster.build_guild
      result = { msg: :success }
    elsif params[:cmd].nil?
      result = { msg: :error, detail: :cmd_nil }
    else
      result = { msg: :error, detail: :no_such_cmd }
    end
    render json: result.as_json(except: [:updated_at, :created_at])
  end
end

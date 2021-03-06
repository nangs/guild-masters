# This class controller retrieves guildmaster's guilds and setting guildmaster's current_guild
# with appropriate references to the database
class GuildSessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize
  respond_to :json

  # POST /guild_sessions.json
  # possible cmd: get, create
  #
  # ----- get --
  # Pre-condition: must be signed in
  # returns json format {guilds: guildmaster.guilds}
  #
  # ----- create --
  # Pre-condition: must be signed in, params guild_id
  # returns json format {msg: :success, guild: guild}
  #
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    if params[:cmd] == 'get'
      result = { guilds: guildmaster.guilds }
    elsif params[:cmd] == 'create'
      @guild_id = params[:guild_id]
      if @guild_id.nil?
        result = { msg: :error, detail: :guild_id_nil }
      elsif !@guild_id.nil?
        guild_exist = Guild.find_by(id: @guild_id)
        if guild_exist
          guildmaster.current_guild_id = @guild_id
          guildmaster.save
          guild = Guild.find(guildmaster.current_guild_id)
          result = { msg: :success, guild: guild }
        elsif !guild_exist
          result = { msg: :error, detail: :no_such_guild_id }
        end
      end
    elsif params[:cmd].nil?
      result = { msg: :error, detail: :cmd_nil }
    else
      result = { msg: :error, detail: :no_such_cmd }
    end
    render json: result.as_json(except: [:updated_at, :created_at])
  end
end

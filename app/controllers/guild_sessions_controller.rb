#This class controller handles the login and sign up values with appropriate references to the database
class GuildSessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize
  respond_to :json

 def index
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guilds = guildmaster.guilds
    render json: guilds.as_json(except: [:updated_at, :created_at])
  end

# POST /guild_sessions.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    @guild_id = params[:guild_id]
    if @guild_id.nil?
      result = {msg: :"error", detail: :"guild_id_nil"}
    elsif !@guild_id.nil?
      guild_exist = Guild.find_by(id: @guild_id)
      if guild_exist
        guildmaster.current_guild_id = @guild_id
        guildmaster.save
        guild = Guild.find(guildmaster.current_guild_id)
        result = {msg: :"success", guild: guild}
      elsif !guild_exist
        result = {msg: :"error", detail: :"no_such_guild_id"}
      end
    end
    render json: result.as_json(except: [:updated_at, :created_at])
  end
end

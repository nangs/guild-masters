#This class controller handles the login and sign up values with appropriate references to the database
class GuildSessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def index
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guilds = guildmaster.guilds
    render json: guilds.as_json(except: [:updated_at, :created_at])
  end

  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guildmaster.current_guild_id = params[:guild_id]
    guildmaster.save
    guild = Guild.find(guildmaster.current_guild_id)
    render json: guild.as_json(except: [:updated_at, :created_at])
  end
end

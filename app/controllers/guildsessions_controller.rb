#This class controller handles the login and sign up values with appropriate references to the database
class GuildsessionsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :verify_authenticity_token

  def index
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guilds = guildmaster.guilds
    respond_to do |format|
      format.json { render json: guilds }
    end
  end

  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guildmaster.current_guild_id = params[:guild_id]
    guildmaster.save
    guild = Guild.find(guildmaster.current_guild_id)
    respond_to do |format|
      format.json { render json: guild.to_json}
    end
  end
end

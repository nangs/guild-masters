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
    session[:guild_id] = params[:guild_id]
    guild = Guild.find(session[:guild_id])
    respond_to do |format|
      format.json { render json: guild.to_json}
    end
  end

  # DELETE /sessions/1.json
  def destroy
    session[:guild_id] = nil
    msg = {msg: "success"}
    respond_to do |format|
      format.json { render json: msg.to_json}
    end
  end

end

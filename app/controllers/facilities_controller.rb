class FacilitiesController < ApplicationController
  respond_to :json
  before_action :authorize

  # POST /facilities.json
  def create
    acc = Account.find_by(id: session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find_by(id: guildmaster.current_guild_id)
    if !guild.nil?
      if params[:cmd] == "get"
        result = {msg: "success", facilities: guild.facilities}
      elsif params[:cmd].nil?
        result = {msg: :"error", detail: :"cmd_nil"}
      else
        result = {msg: :"error", detail: :"no_such_cmd"}
      end
    elsif guild.nil?
      result = {msg: :"error", detail: :"guild_session_not_found"}
    end
    render json: result.as_json(:except => [:created_at, :updated_at])
  end
end
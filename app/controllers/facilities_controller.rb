class FacilitiesController < ApplicationController
  respond_to :json
  before_action :authorize

  # POST /facilities.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    guild = Guild.find(guildmaster.current_guild_id)
    if params[:cmd] == "get"
      result = {msg: "success", facilities: guild.facilities}
    elsif params[:cmd].nil?
      result = {msg: :"error", detail: :"cmd_nil"}
    else
      result = {msg: :"error", detail: :"no_such_cmd"}
    end
    render json: result.as_json(:except => [:created_at, :updated_at])
  end
end
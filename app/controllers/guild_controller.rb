class GuildController < ApplicationController
  respond_to :json
  before_action :authorize

  # POST /guilds.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    if params[:cmd] == "create"
      if guildmaster.build_guild
        result = {msg: :"success"}
      else
        result = {msg: :"error", detail: :"cannot_build_guild"}
      end
    elsif params[:cmd].nil?
      result = {msg: :"error", detail: :"cmd_nil"}
    else
      result = {msg: :"error", detail: :"no_such_cmd"}
    end
    render json: result.as_json
  end
end


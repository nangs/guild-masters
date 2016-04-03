class GuildmasterController < ApplicationController
  respond_to :json
  before_action :authorize

  # # POST /guildmaster.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    if params[:cmd] == "get"
      result = {msg: "success", guildmaster: guildmaster}
    elsif params[:cmd].nil?
      result = {msg: :"error", detail: :"cmd_nil"}
    else
      result = {msg: :"error", detail: :"no_such_cmd"}
    end
    render json: result.as_json(:except => [:created_at, :updated_at])
  end
end


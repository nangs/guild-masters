class GuildmasterController < ApplicationController
  respond_to :json
  before_action :authorize

  # # POST /guildmaster.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    if params[:cmd] == "get"
      render json: guildmaster.as_json(except: [:created_at,:updated_at])
    end
  end
end


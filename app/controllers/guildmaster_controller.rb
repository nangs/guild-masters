class GuildmasterController < ApplicationController
  respond_to :json
  before_action :authorize

  # # GET /guildmaster.json
  def index
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    render json: guildmaster.as_json(except: [:created_at,:updated_at])
  end
end

